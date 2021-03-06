<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Auth\AuthController as Auth;
use App\ResponseCode;
use Illuminate\Http\Request;

class ParentController extends Controller
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
}
