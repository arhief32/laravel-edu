<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Auth\AuthController as Auth;
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
        $payment_gateway = substr($request['BrivaNum'], 0,5);
        $school_gateway = substr($request['BrivaNum'], 5,4);
        $nrp = substr($request['BrivaNum'], 9);

        $response = [
            'BillDetail' => [
                'BillAmount' => '',
                'BillName' => '',
                'BrivaNum' => '',
            ],
            'Info1' => '',
            'Info2' => '',
            'Info3' => '',
            'Info4' => '',
            'Info5' => '',
            'StatusBill' => '',
            'Currency' => '',
        ];
        
        $school_db = $this->selectDatabase($school_gateway);
        if($school_db == null)
        {
            return response()->json($response);
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
            return response()->json($response);
        }

        $BillAmount = [];
                
        foreach($result as $row)
        {
            array_push($BillAmount, $row->amount);
        }
                
        $BillDetail = [
            'BillAmount' => (string)array_sum($BillAmount),
            'BillName' => $result[0]->name,
            'BrivaNum' => $request['BrivaNum'],
        ];

        $response['BillDetail'] = $BillDetail;
        $response['Info1'] = 'Tagihan';
        $response['Info2'] = '';
        $response['Info3'] = '';
        $response['Info4'] = '';
        $response['Info5'] = '';
        $response['StatusBill'] = (string)$result[0]->paidstatus;
        $response['Currency'] = 'IDR';

        return response()->json($response);
    }






    public function requestPayment(Request $request)
    {
        $transaction_id = $request->journal_sequence;
        $school_gateway = substr($request->briva_number, 5,4);
        $payments = $request->detail_payments;

        
        $school_db = $this->selectDatabase($school_gateway);
        
        config(['database.connections.mysql' => [
            'driver' => 'mysql',
            'host' => $school_db->hostname,
            'database' => $school_db->database,
            'username' => $school_db->username,
            'password' => Auth::encrypt_decrypt('decrypt' ,$school_db->password)
        ]]);

        if($payments == false)
        {
            return ['status' => 'gagal'];
        }
        else
        {
            $student = DB::table('student')->select('*')->where('studentID',$payments[0]['studentID'])->first();
            
            foreach($payments as $payment)
            {
                /**
                 * Check history payment if exist
                 */
                if( $payment['paidstatus'] != 2)
                {
                    /**
                     * Insert into globalpayment for graphical dashboard requirement
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
                    ->where('studentID',$payments[0]['studentID'])
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
                            'invoiceID' => $payment['invoiceID'],
                            'studentID' => $student->studentID,
                            'paymentamount' => $payment['amount'],
                            'paymenttype' => 'BRIVA',
                            'paymentdate' => Carbon::now()->format('Y-m-d'),
                            'paymentday' => Carbon::now()->format('d'),
                            'paymentmonth' => Carbon::now()->format('m'),
                            'paymentyear' => Carbon::now()->format('Y'),
                            'userID' => 0,
                            'usertypeID' => 0,
                            'uname' => 'BRI',
                            'transactionID' => $transaction_id,
                            'globalpaymentID' => $global_payment->globalpaymentID
                        ]
                    );
                }
                
                /**
                 * FLAGING
                 */
                // "UPDATE `invoice` SET `paidstatus` = 2 WHERE `invoiceID` = 13"
                DB::table('invoice')
                ->where('invoiceID', $payment['invoiceID'])
                ->update(['paidstatus' => 2]);
            }

            return ['status' => 'berhasil'];
        }
    }
}
