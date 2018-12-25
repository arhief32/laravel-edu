<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Auth\AuthController as Auth;
use App\Http\Controllers\StudentController as Student;
use App\ResponseCode;
use Illuminate\Http\Request;

class TeacherController extends Controller
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

    public function getTeacher(Request $request)
    {
        $auth = Auth::authorization($request);

        if($auth == false)
        {
            return response()->json(ResponseCode::unauthorized());
        }
        else
        {
            if($request->header('userTypeID') == 3)
            {
                // "SELECT * FROM teacher WHERE teacherID in (
                // SELECT teacherID FROM `subject` WHERE `classesID` = '1'
                // )
                // ORDER BY name asc"
                $result = DB::table('teacher')->select(
                    'teacherID',
                    'name',
                    'designation',
                    'dob',
                    'sex',
                    'religion',
                    'email',
                    'phone',
                    'address',
                    'jod',
                    'photo'
                )
                ->where('active', 1)
                ->whereIn('teacherID', 
                    DB::table('subject')
                    ->select('teacherID')
                    ->where('classesID', $auth->classesID)
                )
                ->orderBy('name','asc')
                ->get();
                $this->selectDatabase($request->header('schoolID'));
            }
            else if($request->header('userTypeID') == 4)
            {
                // "SELECT * FROM teacher WHERE teacherID in (
                // SELECT teacherID FROM `subject` WHERE `classesID` in (
                // SELECT classesID FROM `student` LEFT JOIN `studentextend` ON `studentextend`.`studentID` = `student`.`studentID` WHERE `student`.`parentID` = '4' )
                // )
                // ORDER BY name asc"
                $result = DB::table('teacher')->select(
                    'teacherID',
                    'name',
                    'designation',
                    'dob',
                    'sex',
                    'religion',
                    'email',
                    'phone',
                    'address',
                    'jod',
                    'photo'
                )
                ->where('active', 1)
                ->whereIn('teacherID', 
                    DB::table('subject')
                    ->select('teacherID')
                    ->whereIn('classesID',
                    DB::table('student')
                    ->select('student.classesID')
                    ->leftJoin('studentextend','student.studentID','=','studentextend.studentID')
                    ->where('student.parentID', $auth->parentsID)
                    )
                )
                ->orderBy('name','asc')
                ->get();
            }
            else
            {
                return Response()->json(ResponseCode::failed());
            }

            foreach($result as $teacher)
            {
                $teacher->photo = 'http://junio-smart.id/BRI-SmartSchool/uploads/images/'.$teacher->photo;
                $teacher->sex == 'Male' ? $teacher->sex = 'Laki-laki' : $teacher->sex = 'Perempuan';
            }

            return response()->json(ResponseCode::success($result));
        }
    }
}
