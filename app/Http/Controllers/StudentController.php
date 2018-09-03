<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Auth\AuthController as Auth;
use App\ResponseCode;

use Illuminate\Http\Request;

class StudentController extends Controller
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

    public function profile(Request $request)
    {
        if(Auth::authorization($request) == false)
        {
            return response()->json(ResponseCode::unauthorized());
        }
        else
        {
            return response()->json(ResponseCode::authorized(Auth::authorization($request)));
        }
    }

    public function studentAttendance(Request $request)
    {
        $auth = Auth::authorization($request);

        if($auth == false)
        {
            return response()->json(ResponseCode::unauthorized());
        }
        else
        {
            $this->selectDatabase($request->header('schoolID'));
            
            // SELECT * FROM `attendance` 
            // WHERE `studentID` = 'xxx' AND `classesID` = 'xxx' AND `schoolyearID` = 'xxxx' 
            // ORDER BY `monthyear` asc
            $result = DB::table('attendance')->select('attendance.*','student.*')
            ->join('student','attendance.studentID','=','student.studentID')
            ->where('attendance.studentID', $auth->studentID)
            ->orderBy('attendance.monthyear','asc')
            ->get();

            $attendances = array();
            
            foreach($result as $attendance)
            {
                $month_year = $attendance->monthyear;
                
                $details = [
                    $attendance->a1,    $attendance->a2,    $attendance->a3,    $attendance->a4,    $attendance->a5,    $attendance->a6,    $attendance->a7,    $attendance->a8,    $attendance->a9,    $attendance->a10,
                    $attendance->a11,   $attendance->a12,   $attendance->a13,   $attendance->a14,   $attendance->a15,   $attendance->a16,   $attendance->a17,   $attendance->a18,   $attendance->a19,   $attendance->a20,
                    $attendance->a21,   $attendance->a22,   $attendance->a23,   $attendance->a24,   $attendance->a25,   $attendance->a26,   $attendance->a27,   $attendance->a28,   $attendance->a29,   $attendance->a30,
                    $attendance->a31
                ];
                
                $details = implode('|',$details);
                array_push($attendances, 
                [
                    'monthyear' => $month_year,
                    'detail' => $details
                ]);
            }

            $data = [
                'registerNo' => $result[0]->registerNO,
                'name' => $result[0]->name,
                'attendance' => $attendances
            ];

            return response()->json(ResponseCode::success($data));
        }
    }
}
