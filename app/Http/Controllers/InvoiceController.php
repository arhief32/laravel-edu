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
        // $briva_number = $request['BrivaNum'];
        // $payment_gateway = substr($briva_number, 0,5);
        // $school_gateway = substr($briva_number, 5,4);
        // $nrp = substr($briva_number, 9);

        $briva_number = $request['brivaNo'];
        $payment_gateway = substr($briva_number, 0,5);
        $school_gateway = substr($briva_number, 5,4);
        $nrp = substr($briva_number, 9);

        // $response = [
        //     'BillDetail' => [
        //         'BillAmount' => '',
        //         'BillName' => '',
        //         'BrivaNum' => '',
        //     ],
        //     'Info1' => '',
        //     'Info2' => '',
        //     'Info3' => '',
        //     'Info4' => '',
        //     'Info5' => '',
        //     'StatusBill' => '',
        //     'Currency' => '',
        // ];

        $response = [
            'billAmount' => '0',
            'billName' => '',
            'brivaNum' => $briva_number,
            'transactionDateTime' => Carbon::now()->setTimezone('Asia/Jakarta')->format('YmdHms'),
        ];
        
        $school_db = $this->selectDatabase($school_gateway);
        if($school_db == null)
        {
            return response()->json(ResponseCode::brivaNotFound('2' ,$response));
        }
        
        config(['database.connections.mysql' => [
            'driver' => 'mysql',
            'host' => $school_db->hostname,
            'database' => $school_db->database,
            'username' => $school_db->username,
            'password' => Auth::encrypt_decrypt('decrypt' ,$school_db->password)
        ]]);

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
        
        if(count($result) == 0)
        {
            return response()->json(ResponseCode::brivaNotFound('2' ,$response));
        }

        $BillAmount = [];
                
        foreach($result as $row)
        {
            // 1 - (discount/100) * $amount
            $amount = (1-($row->discount/100))*$row->amount;
            array_push($BillAmount, $amount);
        }
            
        // $BillDetail = [
        //     'BillAmount' => (string)array_sum($BillAmount),
        //     'BillName' => $result[0]->name,
        //     'BrivaNum' => $briva_number,
        // ];
        // $response['BillDetail'] = $BillDetail;
        // $response['Info1'] = 'Tagihan';
        // $response['Info2'] = '';
        // $response['Info3'] = '';
        // $response['Info4'] = '';
        // $response['Info5'] = '';
        // $response['StatusBill'] = (string)$result[0]->paidstatus;
        // $response['Currency'] = 'IDR';

        $response['billAmount'] = (string)array_sum($BillAmount);
        $response['billName'] = $result[0]->name;

        $response = ResponseCode::brivaInquirySuccess($response);

        return response()->json($response);
    }






    public function requestPayment(Request $request)
    {
        // $id_app = $request->IdApp;
        // $pass_app = $request->PassApp;
        // $transmisi_date_time = $request->TransmisiDateTime;
        // $bank_id = $request->BankID;
        // $terminal_id = $request->TerminalID;
        // $briva_number = $request->BrivaNum;
        // $payment_amount = $request->PaymentAmount;
        // $transaksi_id = $request->TransaksiID;

        $id_app = $request->idWS;
        $pass_app = $request->tokenWS;
        $transmisi_date_time = $request->transactionDateTime;
        $briva_number = $request->brivaNo;
        $payment_amount = $request->sumAmount;
        $transaksi_id = $request->journalSeq;

        // $response = [
        //     'StatusPayment' => [
        //         'ErrorDesc' => '',
        //         'ErrorCode' => '',
        //         'isError' => '',
        //     ],
        //     'Info1' => '',
        //     'Info2' => '',
        //     'Info3' => '',
        //     'Info4' => '',
        //     'Info5' => '',
        // ];

        $response = [
            'idTransaction' => '',
            'brivaNo' => $briva_number,
            'sumAmount' => $payment_amount,
        ];



        $school_id = substr($briva_number, 5,4);
        $school_db = $this->selectDatabase($school_id);

        if($school_db == null)
        {
            $response['idTransaction'] = '1';
            return response()->json(ResponseCode::brivaPaymentNotMatch($response));
        }

        config(['database.connections.mysql' => [
            'driver' => 'mysql',
            'host' => $school_db->hostname,
            'database' => $school_db->database,
            'username' => $school_db->username,
            'password' => Auth::encrypt_decrypt('decrypt' ,$school_db->password)
        ]]);

        $inquiries = $this->requestInquiry($request);
        
        if($inquiries == false)
        {
            return response()->json(ResponseCode::brivaPaymentNotMatch($response));
        }
        
        $register_number = substr($briva_number, 9);

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

        if(count($invoices) == 0)
        {
            return response()->json(ResponseCode::brivaPaymentNotMatch($response));
        }

        $invoices_amount_total = [];
        
        foreach ($invoices as $invoice)
        {   
            array_push($invoices_amount_total, $invoice->amount);
        }

        $invoices_amount_total = array_sum($invoices_amount_total);

        if($payment_amount == $invoices_amount_total)
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
            
            // $response['StatusPayment']['ErrorDesc'] = 'Sukses';
            // $response['StatusPayment']['ErrorCode'] = '00';
            // $response['StatusPayment']['isError'] = '0';
            // $response['Info1'] = 'Tagihan';
            // $response['Info2'] = $briva_number;
            // $response['Info3'] = $student->name;
            // $response['Info4'] = $payment_amount;
            // $response['Info5'] = '';

            $response['idTransaction'] = implode(', ', $invoices_id);
            
            return response()->json(ResponseCode::brivaPaymentSuccess($response));
        }
        else
        {
            // $response['StatusPayment']['ErrorDesc'] = 'Jumlah nominal pembayaran tidak sama dengan Total Tagihan';
            // $response['StatusPayment']['ErrorCode'] = '04';
            // $response['StatusPayment']['isError'] = '1';
            return response()->json(ResponseCode::brivaPaymentNotMatch($response));
        }
    }
}
