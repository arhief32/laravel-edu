<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Auth\AuthController as Auth;
use App\Http\Controllers\StudentController as Student;
use App\ResponseCode;
use Illuminate\Http\Request;

class AcademicController extends Controller
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

    // getAssignment - student only
    public function getAssignment(Request $request)
    {
        $auth = Auth::authorization($request);

        if($auth == false)
        {
            return response()->json(ResponseCode::unauthorized());
        }
        else
        {
            $this->selectDatabase($request->header('schoolID'));
            
            // "SELECT * FROM `assignment` 
            // LEFT JOIN `subject` ON `subject`.`subjectID` = `assignment`.`subjectID` AND 
            // `subject`.`classesID` = `assignment`.`classesID` 
            // WHERE `assignment`.`schoolyearID` = '1' AND `assignment`.`classesID` = '1'"
            if($request->header('userTypeID') == 3)
            {
                $result = DB::table('assignment')->select('assignment.*','s.*','c.*')
                ->leftJoin('subject as s', 'assignment.subjectID', '=', 's.subjectID')
                ->leftJoin('subject as c', 'assignment.classesID', '=', 'c.subjectID')
                ->where([
                    ['assignment.schoolyearID', $auth->schoolyearID],
                    ['assignment.classesID', $auth->classesID],
                ])
                ->get();

                $assignment_list = [];
                foreach($result as $assignment)
                {
                    array_push($assignment_list, [
                        'title' => $assignment->title,
                        'description' => $assignment->description,
                        'deadline' => $assignment->deadlinedate,
                    ]);
                }
                
                return response()->json(ResponseCode::success([
                    'registerNo' => $auth->registerNO,
                    'name' => $auth->name,
                    'assignmentList' => $assignment_list,
                ]));
            }
            else
            {
                return Response()->json(ResponseCode::failed());
            }
        }
    }
    
    // getSyllabus - parent only
    public function getSyllabus(Request $request)
    {
        $auth = Auth::authorization($request);

        if($auth == false)
        {
            return response()->json(ResponseCode::unauthorized());
        }
        else
        {
            $this->selectDatabase($request->header('schoolID'));
            
            // SELECT * FROM `syllabus` WHERE `classesID` = '1' AND `schoolyearID` = '1' ORDER BY `date` asc
            if($request->header('userTypeID') == 4)
            {
                $result = DB::table('syllabus')->select('*')
                ->where([
                    ['classesID', $request->classesID],
                    ['schoolyearID', $request->schoolyearID],
                ])
                ->orderBy('date','asc')
                ->get();
                
                return response()->json(ResponseCode::success($result));
            }
            else
            {
                return Response()->json(ResponseCode::failed());
            }
        }
    }

    public function getRoutine(Request $request)
    {
        $auth = Auth::authorization($request);

        if($auth == false)
        {
            return response()->json(ResponseCode::unauthorized());
        }
        else
        {
            $this->selectDatabase($request->header('schoolID'));
            
            // "SELECT * FROM `routine` 
            // LEFT JOIN `teacher` ON `teacher`.`teacherID` = `routine`.`teacherID` 
            // LEFT JOIN `classes` ON `classes`.`classesID` = `routine`.`classesID` 
            // LEFT JOIN `section` ON `section`.`sectionID` = `routine`.`sectionID` 
            // LEFT JOIN `subject` ON `subject`.`subjectID` = `routine`.`subjectID` AND `subject`.`classesID` = `routine`.`classesID` 
            // WHERE `routine`.`classesID` = '1' AND `routine`.`sectionID` = '1' AND `routine`.`schoolyearID` = '1'"
            if($request->header('userTypeID') == 3)
            {
                $result = DB::table('routine')->select('routine.*','teacher.*','classes.*','section.*','s.*','c.*')
                ->leftJoin('teacher', 'routine.teacherID', '=', 'teacher.teacherID')
                ->leftJoin('classes', 'routine.subjectID', '=', 'classes.classesID')
                ->leftJoin('section', 'routine.sectionID', '=', 'section.sectionID')
                ->leftJoin('subject as s', 'routine.subjectID', '=', 's.subjectID')
                ->leftJoin('subject as c', 'routine.classesID', '=', 'c.subjectID')
                ->where([
                    ['routine.classesID', $auth->classesID],
                    ['routine.sectionID', $auth->sectionID],
                    ['routine.schoolyearID', $auth->schoolyearID],
                ])
                ->get();
            }
            else if($request->header('userTypeID') == 4)
            {
                $student = Student::getStudent($request);
                
                $result = DB::table('routine')->select('routine.*','teacher.*','classes.*','section.*','s.*','c.*')
                ->leftJoin('teacher', 'routine.teacherID', '=', 'teacher.teacherID')
                ->leftJoin('classes', 'routine.subjectID', '=', 'classes.classesID')
                ->leftJoin('section', 'routine.sectionID', '=', 'section.sectionID')
                ->leftJoin('subject as s', 'routine.subjectID', '=', 's.subjectID')
                ->leftJoin('subject as c', 'routine.classesID', '=', 'c.subjectID')
                ->where([
                    ['routine.classesID', $student->classesID],
                    ['routine.sectionID', $student->sectionID],
                    ['routine.schoolyearID', $student->schoolyearID],
                ])
                ->get();
            }
            else
            {
                return Response()->json(ResponseCode::failed());
            }

            $routine_list = $routine_day = [];

            foreach($result as $routine)
            {
                array_push($routine_day, $routine->day);
            }
            $routine_day = array_values(array_unique($routine_day));
            foreach($routine_day as $day_name)
            {
                $day = [];
                foreach($result as $routine)
                {
                    if($routine->day === $day_name)
                    {
                        array_push($day, [
                            'start_time' => $routine->start_time,
                            'end_time' => $routine->end_time,
                            'room' => $routine->room,
                            'designation' => $routine->designation,
                            'name' => $routine->name,
                        ]);
                    }
                }
                array_push($routine_list, [$day_name => $day]);
            }
            
            if($request->header('userTypeID') == 3)
            {
                return response()->json(ResponseCode::success([
                    'registerNo' => $auth->registerNO,
                    'name' => $auth->name,
                    'routineList' => $routine_list 
                ]));
            }
            else if($request->header('userTypeID') == 4)
            {
                return response()->json(ResponseCode::success([
                    'registerNo' => $student->registerNO,
                    'name' => $student->name,
                    'routineList' => $routine_list 
                ]));
            }
            
        }
    }

    public function getSubject(Request $request)
    {
        $auth = Auth::authorization($request);

        if($auth == false)
        {
            return response()->json(ResponseCode::unauthorized());
        }
        else
        {
            $this->selectDatabase($request->header('schoolID'));
            
            // SELECT * FROM `subject` LEFT JOIN `classes` ON `classes`.`classesID` = `subject`.`classesID` WHERE `subject`.`classesID` = '1'
            if($request->header('userTypeID') == 3)
            {
                $result = DB::table('subject')->select('subject.*','classes.*')
                ->leftJoin('classes', 'subject.classesID', '=', 'classes.classesID')
                ->where('subject.classesID', $auth->classesID)
                ->get();
            }
            else if($request->header('userTypeID') == 4)
            {
                $student = Student::getStudent($request);
                
                $result = DB::table('subject')->select('subject.*','classes.*')
                ->leftJoin('classes', 'subject.classesID', '=', 'classes.classesID')
                ->where('subject.classesID', $student->classesID)
                ->get();
            }
            else
            {
                return Response()->json(ResponseCode::failed());
            }

            $subject_list = [];
            foreach($result as $subject)
            {
                array_push($subject_list, [
                    'subjectCode' => $subject->subject_code,
                    'subjectName' => $subject->subject,
                    'teacher' => $subject->teacher_name,
                    'passMark' => $subject->passmark,
                ]);
            }

            if($request->header('userTypeID') == 3)
            {
                return response()->json(ResponseCode::success([
                    'registerNo' => $auth->registerNO,
                    'name' => $auth->name,
                    'subjectList' => $subject_list,
                ]));
            }
            else if($request->header('userTypeID') == 4)
            {
                return response()->json(ResponseCode::success([
                    'registerNo' => $student->registerNO,
                    'name' => $student->name,
                    'subjectList' => $subject_list,
                ]));
            }
        }
    }
}
