<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Auth\AuthController as Auth;
use App\Http\Controllers\StudentController as Student;
use App\ResponseCode;
use Illuminate\Http\Request;

class AccountController extends Controller
{
    public function selectDatabase($school_id)
    {
        $school_db = DB::connection('school-gateway')->table('schooldb')
        ->select('*')
        ->where('schoolID',$school_id)
        ->first();

        return config(['database.connections.mysql' => [
            'driver' => 'mysql',
            'host' => $school_db->hostname,
            'database' => $school_db->database,
            'username' => $school_db->username,
            'password' => $school_db->password
        ]]);
    }

    public function getInquiryInvoice(Request $request)
    {
        $auth = Auth::authorization($request);

        if($auth == false)
        {
            return response()->json(ResponseCode::unauthorized());
        }
        else
        {
            $this->selectDatabase($request->header('schoolID'));
            
            if($request->header('userTypeID') == 3)
            {
                // SELECT * FROM `invoice` WHERE `RegisterNO` = '2' AND `deleted_at` = 1 ORDER BY `invoiceID` desc
                $result = DB::table('invoice')->select('*')
                ->join('student','student.studentID','=','invoice.studentID')
                ->where([
                    ['student.RegisterNO',$auth->registerNO],
                    ['invoice.deleted_at','1'],
                    ['paidstatus','<>',2]
                    ])
                ->orderBy('invoice.invoiceID','desc')
                ->get();
            }
            else if($request->header('userTypeID') == 4)
            {
                $student = Student::getStudent($request);

                // SELECT * FROM `invoice` WHERE `RegisterNO` = '2' AND `deleted_at` = 1 ORDER BY `invoiceID` desc
                $result = DB::table('invoice')->select('*')
                ->join('student','student.studentID','=','invoice.studentID')
                ->where([
                    ['student.RegisterNO',$student->registerNO],
                    ['invoice.deleted_at','1'],
                    ['paidstatus','<>',2]
                    ])
                ->orderBy('invoice.invoiceID','desc')
                ->get();
            }
            else
            {
                return Response()->json(ResponseCode::failed());
            }

            $invoice_detail = [];
            $sum_amount = [];

            foreach($result as $invoice)
            {
                array_push($invoice_detail, [
                    'feeType' => $invoice->feetype,
                    'amount' => $invoice->amount,
                ]);
                array_push($sum_amount, $invoice->amount);
            }
            
            $sum_amount = array_sum($sum_amount);

            $briva_code = DB::connection('school-gateway')
            ->table('schooldb')
            ->select('*')
            ->where('schoolID', $request->header('schoolID'))
            ->first();
            
            if($request->header('userTypeID') == 3)
            {
                return response()->json(ResponseCode::success([
                    'registerNo' => $auth->registerNO,
                    'name' => $auth->name,
                    'sumAmount' => $sum_amount,
                    'brivaNumber' => $briva_code->brivaNo . $briva_code->schoolID . $auth->registerNO,
                    'detailInvoice' => $invoice_detail,
                ]));
            }
            else if($request->header('userTypeID') == 4)
            {
                return response()->json(ResponseCode::success([
                    'registerNo' => $student->registerNO,
                    'name' => $student->name,
                    'sumAmount' => $sum_amount,
                    'brivaNumber' => $briva_code->brivaNo . $briva_code->schoolID . $student->registerNO,
                    'detailInvoice' => $invoice_detail,
                ]));
            }
        }
    }

    public function getPaymentHistory(Request $request)
    {
        $auth = Auth::authorization($request);

        if($auth == false)
        {
            return response()->json(ResponseCode::unauthorized());
        }
        else
        {
            $this->selectDatabase($request->header('schoolID'));
            
            if($request->header('userTypeID') == 3)
            {
                // "SELECT `payment`.*, `invoice`.`invoiceID`, `invoice`.`feetype`, `invoice`.`amount`, `studentrelation`.* 
                // FROM `payment` 
                // LEFT JOIN `studentrelation` ON `studentrelation`.`srstudentID` = `payment`.`studentID` 
                // AND `studentrelation`.`srschoolyearID` = `payment`.`schoolyearID` 
                // LEFT JOIN `invoice` ON `invoice`.`invoiceID` = `payment`.`invoiceID` 
                // WHERE `payment`.`studentID` = (SELECT studentID FROM `student` where username = 'student02' limit 1)"
                $result = DB::table('payment')->select(
                    'invoice.feetype',
                    'invoice.amount',
                    'invoice.paidstatus',
                    'payment.paymentdate',
                    'payment.transactionID'
                    )
                // ->join('studentrelation as a','payment.studentID','=','a.srstudentID')
                // ->join('studentrelation as b','payment.schoolyearID','=','b.srschoolyearID')
                ->join('invoice','payment.invoiceID','=','invoice.invoiceID')
                ->where('payment.studentID',$auth->studentID)
                // ->limit(15)
                ->get();
            }
            else if($request->header('userTypeID') == 4)
            {
                $student = Student::getStudent($request);

                // "SELECT `payment`.*, `invoice`.`invoiceID`, `invoice`.`feetype`, `invoice`.`amount`, `studentrelation`.* 
                // FROM `payment` 
                // LEFT JOIN `studentrelation` ON `studentrelation`.`srstudentID` = `payment`.`studentID` 
                // AND `studentrelation`.`srschoolyearID` = `payment`.`schoolyearID` 
                // LEFT JOIN `invoice` ON `invoice`.`invoiceID` = `payment`.`invoiceID` 
                // WHERE `payment`.`studentID` = (SELECT studentID FROM `student` where username = 'student02' limit 1)"
                $result = DB::table('payment')->select(
                    'invoice.feetype',
                    'invoice.amount',
                    'invoice.paidstatus',
                    'payment.paymentdate',
                    'payment.transactionID'
                    )
                // ->join('studentrelation as a','payment.studentID','=','a.srstudentID')
                // ->join('studentrelation as b','payment.schoolyearID','=','b.srschoolyearID')
                ->join('invoice','payment.invoiceID','=','invoice.invoiceID')
                ->where('payment.studentID',$student->studentID)
                // ->limit(15)
                ->get();
            }
            else
            {
                return Response()->json(ResponseCode::failed());
            }

            $payment_detail = [];
            
            foreach($result as $payment)
            {
                $payment->paidstatus == 2 ? $payment->paidstatus = 'Paid' : $payment->paidstatus = 'Not paid'; 

                array_push($payment_detail, [
                    'feeType' => $payment->feetype,
                    'amount' => $payment->amount,
                    'status' => $payment->paidstatus,
                    'paymentDate' => $payment->paymentdate,
                    'transactionID' => $payment->transactionID,
                ]);
            }
            
            $briva_code = DB::connection('school-gateway')
            ->table('schooldb')
            ->select('*')
            ->where('schoolID', $request->header('schoolID'))
            ->first();
            
            if($request->header('userTypeID') == 3)
            {
                return response()->json(ResponseCode::success([
                    'registerNo' => $auth->registerNO,
                    'name' => $auth->name,
                    'brivaNumber' => $briva_code->brivaNo . $briva_code->schoolID . $auth->registerNO,
                    'detailPayment' => $payment_detail,
                ]));
            }
            else if($request->header('userTypeID') == 4)
            {
                return response()->json(ResponseCode::success([
                    'registerNo' => $student->registerNO,
                    'name' => $student->name,
                    'brivaNumber' => $briva_code->brivaNo . $briva_code->schoolID . $student->registerNO,
                    'detailPayment' => $payment_detail,
                ]));
            }
        }
    }
}
