<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Auth\AuthController as Auth;
use App\Http\Controllers\StudentController as Student;
use App\ResponseCode;
use Illuminate\Http\Request;

class AttendanceController extends Controller
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
    
    public function studentList(Request $request)
    {
        $auth = Auth::authorization($request);

        if($auth == false)
        {
            return response()->json(ResponseCode::unauthorized());
        }
        else
        {
            $this->selectDatabase($request->header('schoolID'));
            
            // "SELECT * FROM `student` LEFT JOIN `studentextend` ON `studentextend`.`studentID` = `student`.`studentID` 
            // WHERE `student`.`parentID` = 'xxx' ORDER BY `roll` asc"
            $result = DB::table('student')->select(
                'student.studentID',
                'student.registerNO',
                'classes.classes',
                'section.section',
                'student.name',
                'student.photo'
            )
            ->leftJoin('studentextend', 'studentextend.studentID', '=', 'student.studentID')
            ->leftJoin('classes', 'student.classesID', '=', 'classes.classesID')
            ->leftJoin('section', 'student.sectionID', '=', 'section.sectionID')
            ->where('student.parentID', $auth->parentsID)
            ->orderBy('student.registerNO','asc')
            ->get();

            foreach($result as $student)
            {
                $student->photo = 'http://172.18.133.135:81/BRI-SmartSchool/uploads/images/'.$student->photo;
            }
            
            return response()->json(ResponseCode::success($result));
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
                
                $details_v1 = [
                    $attendance->a1,    $attendance->a2,    $attendance->a3,    $attendance->a4,    $attendance->a5,    $attendance->a6,    $attendance->a7,    $attendance->a8,    $attendance->a9,    $attendance->a10,
                    $attendance->a11,   $attendance->a12,   $attendance->a13,   $attendance->a14,   $attendance->a15,   $attendance->a16,   $attendance->a17,   $attendance->a18,   $attendance->a19,   $attendance->a20,
                    $attendance->a21,   $attendance->a22,   $attendance->a23,   $attendance->a24,   $attendance->a25,   $attendance->a26,   $attendance->a27,   $attendance->a28,   $attendance->a29,   $attendance->a30,
                    $attendance->a31
                ];

                $details_v2 = [];
                foreach ($details_v1 as $detail)
                {
                    $detail == null ? array_push($details_v2, '-') : array_push($details_v2, $detail);
                }
                
                // $details = implode('|',$details);
                array_push($attendances, 
                [
                    'monthyear' => $month_year,
                    'detail' => $details_v2
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

    public function studentAttendanceParent(Request $request)
    {
        $auth = Auth::authorization($request);

        if($auth == false)
        {
            return response()->json(ResponseCode::unauthorized());
        }
        else
        {
            $this->selectDatabase($request->header('schoolID'));
            $student = Student::getStudent($request);
            // SELECT * FROM `attendance` 
            // WHERE `studentID` = 'xxx' AND `classesID` = 'xxx' AND `schoolyearID` = 'xxxx' 
            // ORDER BY `monthyear` asc
            $result = DB::table('attendance')->select('attendance.*','student.*')
            ->join('student','attendance.studentID','=','student.studentID')
            ->where([['attendance.studentID', $student->studentID],['attendance.classesID', $student->classesID],['attendance.schoolyearID', $student->schoolyearID]])
            ->orderBy('attendance.monthyear','asc')
            ->get();

            $attendances = array();
            
            foreach($result as $attendance)
            {
                $month_year = $attendance->monthyear;
                
                $details_v1 = [
                    $attendance->a1,    $attendance->a2,    $attendance->a3,    $attendance->a4,    $attendance->a5,    $attendance->a6,    $attendance->a7,    $attendance->a8,    $attendance->a9,    $attendance->a10,
                    $attendance->a11,   $attendance->a12,   $attendance->a13,   $attendance->a14,   $attendance->a15,   $attendance->a16,   $attendance->a17,   $attendance->a18,   $attendance->a19,   $attendance->a20,
                    $attendance->a21,   $attendance->a22,   $attendance->a23,   $attendance->a24,   $attendance->a25,   $attendance->a26,   $attendance->a27,   $attendance->a28,   $attendance->a29,   $attendance->a30,
                    $attendance->a31
                ];

                $details_v2 = [];
                foreach ($details_v1 as $detail)
                {
                    $detail == null ? array_push($details_v2, '-') : array_push($details_v2, $detail);
                }
                
                // $details = implode('|',$details);
                array_push($attendances, 
                [
                    'monthyear' => $month_year,
                    'detail' => $details_v2
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
