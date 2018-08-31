<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

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
        $payment_gateway = substr($request->BrivaNum, 0,5);
        $school_gateway = substr($request->BrivaNum, 5,4);
        $nrp = substr($request->BrivaNum, 9,5);

        $school_db = $this->selectDatabase($school_gateway);
        
        config(['database.connections.mysql' => [
            'driver' => 'mysql',
            'host' => $school_db->hostname,
            'database' => $school_db->database,
            'username' => $school_db->username,
            'password' => $school_db->password
        ]]);

        // SELECT * FROM `invoice` WHERE `RegisterNO` = '2' AND `deleted_at` = 1 ORDER BY `invoiceID` desc
        $result = DB::table('invoice')->select('*')
        ->join('student','student.studentID','=','invoice.studentID')
        ->where([
            ['student.RegisterNO',$nrp],
            ['invoice.deleted_at','1'],           
            ])
        ->orderBy('invoice.invoiceID','desc')
        ->get();

        return response()->json($result);
    }

    public function requestPayment(Request $request)
    {
        $transaction_id = $request->journal_sequence;
        $school_gateway = substr($request->briva_number, 5,4);
        $payments = $request->detail_payments;

        return response()->json(['transaction_id' => $transaction_id,'school_id' => $school_gateway,'payments' => $payments]);
        
        // $school_db = $this->selectDatabase($school_gateway);
        
        // config(['database.connections.mysql' => [
        //     'driver' => 'mysql',
        //     'host' => $school_db->hostname,
        //     'database' => $school_db->database,
        //     'username' => $school_db->username,
        //     'password' => $school_db->password
        // ]]);

        // foreach($payments as $payment)
        // {
        //     // DB::table('payment')->insert(
        //     //     [
        //     //         'invoiceID' => $payment->invoiceID, 
        //     //         'schoolyearID' => $payment->schoolyear,
        //     //         'studentID' => $payment->studentID,
        //     //         'paymentamount' => $payment->paymentamount,
        //     //         'paymenttype' => $payment->paymenttype,
        //     //         'paymentdate' => $payment->paymentdate,
        //     //         'paymentday' => $payment->paymentday,
        //     //         'paymentmonth' => $payment->paymentmonth,
        //     //         'paymentyear' => $payment->paymentyear,
        //     //         'userID' => $payment->userID,
        //     //         'usertypeID' => $payment->usertypeID,
        //     //         'transactionID' => $transaction_id,
        //     //         'globalpaymentID' => $payment->invoiceID
        //     //     ]
        //     // );
        // }

        // return response()->json($request);
        
        // if($payments == false)
        // {
        //     return ['status' => 'gagal'];
        // }
        // else
        // {
        //     return ['status' => 'berhasil'];
        // }
    }
}
