<?php

namespace App\Http\Controllers\Auth;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use App\ResponseCode;

class AuthController extends Controller
{
    /**
     * Validasi login
     */
    public function validation(Request $request)
    {
        $school_db = DB::table('schooldb')
        ->select('database')
        ->where('schoolID',$request->school_id)
        ->first();
        $username = $request->username;
        $password = $this->hash($request->password);

        return [
            'school_db' => $school_db->database,
            'username' => $username,
            'password' => $password,
        ];
    }

    /**
     * Enkripsi password
     */
    public function hash($string) 
    {
		return hash("sha512", $string . "ceca0623e7992c1620c7372408b6f41d");
    }

    /**
     * login
     */
    public function login(Request $request)
    {
        // mengecek value dari login
        if($request->school_id == '' || $request->username == '' || $request->password == '')
        {
            return response()->json(ResponseCode::login_failed());
        }

        // mencari dan mencocokkan value ke database
        $validate_auth = DB::table($this->validation($request)['school_db'].'.student')
        ->select('username','password','usertypeID as user_type_id')
        ->where([['username',$this->validation($request)['username']],['password',$this->validation($request)['password']]])
        ->first();
        
        // response
        if($validate_auth == true)
        {
            $validate_auth->school_id = $request->school_id;
            
            return response()->json(ResponseCode::login_success($validate_auth));
        }
        else
        {
            return response()->json(ResponseCode::login_failed());
        }
    }

    /**
     * Authorization for all action foreach middleware or user_type_id
     */
    public static function authorization(Request $request)
    {
        // mengecek value untuk authentication
        if($request->header('school_id') == '' ||
        $request->header('username') == '' ||
        $request->header('password') == '' ||
        $request->header('user_type_id') == '')
        {
            return response()->json(ResponseCode::unauthorized());
        }

        // define variable
        $username = $request->header('username');
        $password = $request->header('password');
        $user_type_id = $request->header('user_type_id');
        $school_db = DB::table('schooldb')
        ->select('database')
        ->where('schoolID',$request->header('school_id'))
        ->first();

        // validasi auth
        if($school_db == false)
        {
            return response()->json(ResponseCode::unauthorized());
        }
        
        $check_student_auth = DB::table($school_db->database.'.student')
        ->select('*')
        ->where([['username',$username],['password',$password],['usertypeID',$user_type_id]])
        ->first();

        $check_parent_auth = DB::table($school_db->database.'.parents')
        ->select('*')
        ->where([['username',$username],['password',$password],['usertypeID',$user_type_id]])
        ->first();

        // response
        if($check_student_auth == true)
        {
            return response()->json(ResponseCode::authorized($check_student_auth));
        }
        elseif($check_parent_auth == true)
        {
            return response()->json(ResponseCode::authorized($check_parent_auth));
        }
        else
        {
            return response()->json(ResponseCode::unauthorized());
        }
    }
}
