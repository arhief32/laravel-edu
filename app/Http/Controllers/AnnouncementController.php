<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Auth\AuthController as Auth;
use App\ResponseCode;
use Illuminate\Http\Request;

class AnnouncementController extends Controller
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

    public function getNotice(Request $request)
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
                // SELECT * FROM `notice` WHERE `schoolyearID` = '1' ORDER BY `noticeID` desc
                $result = DB::table('notice')->select('*')
                ->where('schoolyearID', $auth->schoolyearID)
                ->orderBy('noticeID','desc')
                ->get();
            }
            else if($request->header('userTypeID') == 4)
            {
                // "SELECT * FROM `notice` WHERE (
                // SELECT schoolyearID FROM `student` where username = 'student02' limit 1
                // ) ORDER BY `noticeID` desc"
                $school_year_id = DB::table('student')->select('schoolyearID')
                ->where('username', $request->username)
                ->first();
                
                $result = DB::table('notice')->select('*')
                ->where('schoolyearID', $school_year_id->schoolyearID)
                ->orderBy('noticeID','desc')
                ->get();
            }
            else
            {
                return Response()->json(ResponseCode::failed());
            }

            $notice_detail = [];
            foreach($result as $notice)
            {
                array_push($notice_detail, [
                    'title' => $notice->title,
                    'date' => $notice->date,
                    'notice' => $notice->notice,
                ]);
            }

            return response()->json(ResponseCode::success(['noticeDetail' => $notice_detail]));
        }
    }
    
    public function getEvent(Request $request)
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
                // SELECT * FROM `event` WHERE `schoolyearID` = '1' ORDER BY `fdate` desc, `ftime` asc
                $result = DB::table('event')->select('*')
                ->where('schoolyearID', $auth->schoolyearID)
                ->orderBy('fdate','desc')
                ->orderBy('ftime','asc')
                ->get();
            }
            else if($request->header('userTypeID') == 4)
            {
                // "SELECT * FROM `event` WHERE (
                // SELECT schoolyearID FROM `student` where username = 'student02' limit 1
                // ) ORDER BY `fdate` desc, `ftime` asc"
                $school_year_id = DB::table('student')->select('schoolyearID')
                ->where('username', $request->username)
                ->first();
                
                $result = DB::table('event')->select('*')
                ->where('schoolyearID', $school_year_id->schoolyearID)
                ->orderBy('fdate','desc')
                ->orderBy('ftime','asc')
                ->get();
            }
            else
            {
                return Response()->json(ResponseCode::failed());
            }

            $event_detail = [];
            foreach($result as $event)
            {
                array_push($event_detail, [
                    'title' => $event->title,
                    'fromDate' => $event->fdate,
                    'toDate' => $event->ttime,
                    'details' => $event->details,
                    'photo' => $event->photo,
                ]);
            }

            return response()->json(ResponseCode::success(['eventDetail' => $event_detail]));
        }
    }

    public function getHoliday(Request $request)
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
                // SELECT * FROM `holiday` WHERE `schoolyearID` = '1' ORDER BY `fdate` asc
                $result = DB::table('holiday')->select('*')
                ->where('schoolyearID', $auth->schoolyearID)
                ->orderBy('fdate','asc')
                ->get();
            }
            else if($request->header('userTypeID') == 4)
            {
                // "SELECT * FROM `holiday` WHERE (
                // SELECT schoolyearID FROM `student` where username = 'student02' limit 1
                // ) ORDER BY `fdate` asc"
                $school_year_id = DB::table('student')->select('schoolyearID')
                ->where('username', $request->username)
                ->first();
                
                $result = DB::table('holiday')->select('*')
                ->where('schoolyearID', $school_year_id->schoolyearID)
                ->orderBy('fdate','asc')
                ->get();
            }
            else
            {
                return Response()->json(ResponseCode::failed());
            }

            $holiday_detail = [];
            foreach($result as $holiday)
            {
                array_push($holiday_detail, [
                    'title' => $holiday->title,
                    'fromDate' => $holiday->fdate,
                    'toDate' => $holiday->tdate,
                    'details' => $holiday->details,
                    'photo' => $holiday->photo,
                ]);
            }

            return response()->json(ResponseCode::success(['holidayDetail' => $holiday_detail]));
        }
    }
}
