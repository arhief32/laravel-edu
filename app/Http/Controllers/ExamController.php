<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Auth\AuthController as Auth;
use App\Http\Controllers\StudentController as Student;
use App\ResponseCode;
use Illuminate\Http\Request;

class ExamController extends Controller
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

    public function getExamSchedule(Request $request)
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
                // "SELECT * FROM `examschedule` LEFT JOIN `exam` ON `exam`.`examID` = `examschedule`.`examID` 
                // LEFT JOIN `classes` ON `classes`.`classesID` = `examschedule`.`classesID` 
                // LEFT JOIN `section` ON `section`.`sectionID` = `examschedule`.`sectionID` 
                // LEFT JOIN `subject` ON `subject`.`subjectID` = `examschedule`.`subjectID` 
                // WHERE `examschedule`.`classesID` = 'xxx' AND `examschedule`.`sectionID` = 'xxx' AND `examschedule`.`schoolyearID` = 'xxx'"
                $result = DB::table('examschedule')->select('*')
                ->leftJoin('exam','examschedule.examID','=','exam.examID')
                ->leftJoin('classes','examschedule.classesID','=','classes.classesID')
                ->leftJoin('section','examschedule.sectionID','=','section.sectionID')
                ->leftJoin('subject','examschedule.subjectID','=','subject.subjectID')
                ->where([
                    ['examschedule.classesID',$auth->classesID],
                    ['examschedule.sectionID',$auth->sectionID],
                    ['examschedule.schoolyearID',$auth->schoolyearID]
                    ])
                ->get();
            }
            else if($request->header('userTypeID') == 4)
            {
                $student = Student::getStudent($request);

                // "SELECT * FROM `examschedule` LEFT JOIN `exam` ON `exam`.`examID` = `examschedule`.`examID` 
                // LEFT JOIN `classes` ON `classes`.`classesID` = `examschedule`.`classesID` 
                // LEFT JOIN `section` ON `section`.`sectionID` = `examschedule`.`sectionID` 
                // LEFT JOIN `subject` ON `subject`.`subjectID` = `examschedule`.`subjectID` 
                // WHERE `examschedule`.`classesID` = 'xxx' AND `examschedule`.`sectionID` = 'xxx' AND `examschedule`.`schoolyearID` = 'xxx'"
                $result = DB::table('examschedule')->select('*')
                ->leftJoin('exam','examschedule.examID','=','exam.examID')
                ->leftJoin('classes','examschedule.classesID','=','classes.classesID')
                ->leftJoin('section','examschedule.sectionID','=','section.sectionID')
                ->leftJoin('subject','examschedule.subjectID','=','subject.subjectID')
                ->where([
                    ['examschedule.classesID',$student->classesID],
                    ['examschedule.sectionID',$student->sectionID],
                    ['examschedule.schoolyearID',$student->schoolyearID]
                    ])
                ->get();
            }
            else
            {
                return Response()->json(ResponseCode::failed());
            }

            $exam_schedule = [];

            foreach($result as $schedule)
            {
                array_push($exam_schedule, [
                    'examName' => $schedule->exam,
                    'class' => $schedule->classes,
                    'section' => $schedule->section,
                    'subject' => $schedule->subject,
                    'date' => $schedule->date,
                    'time' => $schedule->examfrom.' - '.$schedule->examto,
                    'room' => $schedule->room,
                ]);
            }
            
            if($request->header('userTypeID') == 3)
            {
                return response()->json(ResponseCode::success([
                    'registerNo' => $auth->registerNO,
                    'name' => $auth->name,
                    'examSchedule' => $exam_schedule,
                ]));
            }
            else if($request->header('userTypeID') == 4)
            {
                return response()->json(ResponseCode::success([
                    'registerNo' => $student->registerNO,
                    'name' => $student->name,
                    'examSchedule' => $exam_schedule,
                ]));
            }
        }
    }

    public function getExamMark(Request $request)
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
                // "SELECT * FROM `mark` LEFT JOIN `markrelation` ON `markrelation`.`markID` = `mark`.`markID` 
                // WHERE `mark`.`schoolyearID` = '1' AND `mark`.`classesID` = '1' AND `mark`.`studentID` = '1'"
                $result = DB::table('mark')->select('*')
                ->leftJoin('markrelation','mark.markID','=','markrelation.markID')
                ->where([
                    ['mark.schoolyearID',$auth->schoolyearID],
                    ['mark.classesID',$auth->classesID],
                    ['mark.studentID',$auth->studentID]
                    ])
                ->get();

                // return response()->json($result);
            }
            else if($request->header('userTypeID') == 4)
            {
                $student = Student::getStudent($request);

                // "SELECT * FROM `mark` LEFT JOIN `markrelation` ON `markrelation`.`markID` = `mark`.`markID` 
                // WHERE `mark`.`schoolyearID` = '1' AND `mark`.`classesID` = '1' AND `mark`.`studentID` = '1'"
                $result = DB::table('mark')->select('*')
                ->leftJoin('markrelation','mark.markID','=','markrelation.markID')
                ->where([
                    ['mark.schoolyearID',$student->schoolyearID],
                    ['mark.classesID',$student->classesID],
                    ['mark.studentID',$student->studentID]
                    ])
                ->get();

                // return response()->json($result);
            }
            else
            {
                return Response()->json(ResponseCode::failed());
            }

            $exam_mark = [];

            foreach($result as $mark)
            {
                array_push($exam_mark, [
                    'markName' => $mark->exam,
                    'subject' => $mark->subject,
                    'mark' => $mark->mark,
                ]);
            }
            
            if($request->header('userTypeID') == 3)
            {
                return response()->json(ResponseCode::success([
                    'registerNo' => $auth->registerNO,
                    'name' => $auth->name,
                    'markDetail' => $exam_mark,
                ]));
            }
            else if($request->header('userTypeID') == 4)
            {
                return response()->json(ResponseCode::success([
                    'registerNo' => $student->registerNO,
                    'name' => $student->name,
                    'markDetail' => $exam_mark,
                ]));
            }
        }
    }
}
