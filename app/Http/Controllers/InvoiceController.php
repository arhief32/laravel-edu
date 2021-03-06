<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Auth\AuthController as Auth;
use App\ResponseCode;
use Carbon\Carbon;

class InvoiceController extends Controller
{
    public function selectDatabase($school_id)
    {
        $school_db = DB::connection('school-gateway')->table('schooldb')
        ->select('*')
        ->where('schoolID',$school_id)
        ->first();

        return $school_db;
    }

    public function requestInquiry(Request $request)
    {
        $id_ws = $request->idWS;
        $token_ws = $request->tokenWS;
        $briva_number = $request['brivaNo'];
        $payment_gateway = substr($briva_number, 0,5);
        $school_gateway = substr($briva_number, 5,4);
        $nrp = substr($briva_number, 9);

        $response = [
            'billAmount' => '0',
            'billName' => '',
            'billInfo' => '',
            'brivaNo' => $briva_number,
            'transactionDateTime' => Carbon::now()->setTimezone('Asia/Jakarta')->format('YmdHms'),
        ];
        
        $self_id_ws = 'WS-Edu';
        $self_token_ws = 'V0pjQVpnOGhqYnloSmNLcFNIOExWUT09';
        
        if($id_ws == $self_id_ws && $token_ws == $self_token_ws)
        {
            $school_db = $this->selectDatabase($school_gateway);
            
            if($school_db == null)
            {
                return response()->json(ResponseCode::brivaDatabaseNotFound($response));
            }
            
            config(['database.connections.mysql' => [
                'driver' => 'mysql',
                'host' => $school_db->hostname,
                'database' => $school_db->database,
                'username' => $school_db->username,
                'password' => Auth::encrypt_decrypt('decrypt' ,$school_db->password)
            ]]);
            
            try
            {
                // SELECT * FROM `invoice` WHERE `RegisterNO` = '2' AND `deleted_at` = 1 ORDER BY `invoiceID` desc
                $result = DB::table('invoice')->select('*')
                ->join('student','student.studentID','=','invoice.studentID')
                ->where([
                    ['student.RegisterNO',$nrp],
                    ['invoice.deleted_at','1'],
                    ['paidstatus','<>',2]
                    ])
                ->orderBy('invoice.invoiceID','desc')
                ->get();
            }
            catch(\Illuminate\Database\QueryException $error)
            {
                return response()->json(ResponseCode::brivaDatabaseNotFound($response));
            }

            if(count($result) == 0)
            {
                return response()->json(ResponseCode::brivaNotFound('2' ,$response));
            }
    
            $BillAmount = [];
            $invoices_id = [];
                    
            foreach($result as $row)
            {
                // 1 - (discount/100) * $amount
                $amount = (1-($row->discount/100))*$row->amount;
                array_push($BillAmount, $amount);
                array_push($invoices_id, $row->invoiceID);
            }
    
            $invoices_id = implode(', ',$invoices_id);
                
            $response['billAmount'] = (string)array_sum($BillAmount);
            $response['billName'] = $result[0]->name;
            $response['billInfo'] = $invoices_id;
    
            $response = ResponseCode::brivaInquirySuccess($response);
    
            return response()->json($response);
        }
        else
        {
            return ResponseCode::brivaNotAuthorized('2', $response);
        }
    }

    public function requestPayment(Request $request)
    {
        $id_app = $request->idWS;
        $pass_app = $request->tokenWS;
        $transmisi_date_time = $request->transactionDateTime;
        $briva_number = $request->brivaNo;
        $payment_amount = $request->billAmount;
        $transaksi_id = $request->journalSeq;

        $response = [
            'idTransaction' => '',
            'brivaNo' => $briva_number,
            'billAmount' => $payment_amount,
            'transactionDateTime' => Carbon::now()->setTimezone('Asia/Jakarta')->format('YmdHms'),
        ];

        $self_id_ws = 'WS-Edu';
        $self_token_ws = 'V0pjQVpnOGhqYnloSmNLcFNIOExWUT09';

        if($id_app == $self_id_ws && $pass_app == $self_token_ws)
        {
            $school_id = substr($briva_number, 5,4);
            $school_db = $this->selectDatabase($school_id);

            if($school_db == null)
            {
                $response['idTransaction'] = '1';
                return response()->json(ResponseCode::brivaDatabaseNotFound($response));
            }

            config(['database.connections.mysql' => [
                'driver' => 'mysql',
                'host' => $school_db->hostname,
                'database' => $school_db->database,
                'username' => $school_db->username,
                'password' => Auth::encrypt_decrypt('decrypt' ,$school_db->password)
            ]]);

            $register_number = substr($briva_number, 9);

            try
            {
                // SELECT * FROM `invoice` WHERE `RegisterNO` = '2' AND `deleted_at` = 1 ORDER BY `invoiceID` desc
                $invoices = DB::table('invoice')->select('*')
                ->join('student','student.studentID','=','invoice.studentID')
                ->where([
                    ['student.RegisterNO',$register_number],
                    ['invoice.deleted_at','1'],
                    ['paidstatus','<>',2]
                ])
                ->orderBy('invoice.invoiceID','desc')
                ->get();
            }
            catch(\Illuminate\Database\QueryException $error)
            {
                return response()->json(ResponseCode::brivaDatabaseNotFound($response));
            }

            if(count($invoices) == 0)
            {
                return response()->json(ResponseCode::brivaPaymentNotFound($response));
            }

            $invoices_amount_total = [];

            foreach ($invoices as $invoice)
            {   
                // 1 - (discount/100) * $amount
                $amount = (1-($invoice->discount/100))*$invoice->amount;
                array_push($invoices_amount_total, $amount);
            }

            $invoices_amount_total = array_sum($invoices_amount_total);

            if($payment_amount == $invoices_amount_total)
            // if($payment_amount == $invoices_amount_total)
            {
                $student = DB::table('student')->select('*')->where('registerNO',$register_number)->first();

                $invoices_id = [];

                foreach($invoices as $invoice)
                {
                    if($invoice->paidstatus != 2)
                    {
                        /**
                         * Check history payment if exist
                         */
                        DB::table('globalpayment')->insert(
                            [
                                'classesID' => $student->classesID,
                                'sectionID' => $student->sectionID,
                                'studentID' => $student->studentID,
                                'clearancetype' => 'paid',
                                'invoicename' => $student->registerNO.' - '.$student->name,
                                'invoicedescription' => '',
                                'paymentyear' => Carbon::now()->format('Y'),
                                'schoolyearID' => $student->schoolyearID,
                            ]
                        );
                    
                        $global_payment = DB::table('globalpayment')->select('*')
                        ->where('studentID',$student->studentID)
                        ->orderBy('globalpaymentID','desc')
                        ->first();
                    
                        /**
                         * Insert into payment for flaging requirement
                         */
                        // """INSERT INTO `payment` 
                        // (`invoiceID`, `schoolyearID`, `studentID`, `paymentamount`, `paymenttype`, `paymentdate`, `paymentday`, `paymentmonth`, 
                        // `paymentyear`, `userID`, `usertypeID`, `uname`, `transactionID`, `globalpaymentID`) 
                        // VALUES 
                        // ('13', '1', '2', '100000', 'Cash', '2018-08-23', '23', '08', '2018', '1', '1', 'admin', 'CASHANDCHEQUE-12584959', 1)"""
                        DB::table('payment')->insert(
                            [
                                'schoolyearID' => $student->schoolyearID,
                                'invoiceID' => $invoice->invoiceID,
                                'studentID' => $student->studentID,
                                'paymentamount' => $invoice->amount,
                                'paymenttype' => 'BRIVA',
                                'paymentdate' => Carbon::now()->format('Y-m-d'),
                                'paymentday' => Carbon::now()->format('d'),
                                'paymentmonth' => Carbon::now()->format('m'),
                                'paymentyear' => Carbon::now()->format('Y'),
                                'userID' => 0,
                                'usertypeID' => 0,
                                'uname' => 'BRI',
                                'transactionID' => $transaksi_id,
                                'globalpaymentID' => $global_payment->globalpaymentID
                            ]
                        );
                    }

                    array_push($invoices_id, $invoice->invoiceID);

                    /**
                     * FLAGING
                     */
                    // "UPDATE `invoice` SET `paidstatus` = 2 WHERE `invoiceID` = 13"
                    DB::table('invoice')
                    ->where('invoiceID', $invoice->invoiceID)
                    ->update(['paidstatus' => 2]);

                }

                $response['idTransaction'] = implode(', ', $invoices_id);

                return response()->json(ResponseCode::brivaPaymentSuccess($response));
            }
            else
            {
                return response()->json(ResponseCode::brivaPaymentNotMatch($response));
            }
        }
        else
        {
            return response()->json(ResponseCode::brivaNotAuthorized('11', $response));
        }

        
    }
}
