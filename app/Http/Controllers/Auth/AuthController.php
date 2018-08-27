<?php

namespace App\Http\Controllers\Auth;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;

class AuthController extends Controller
{
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

    public function hash($string) 
    {
		return hash("sha512", $string . "ceca0623e7992c1620c7372408b6f41d");
    }

    public function login(Request $request)
    {
        $validate_auth = DB::table($this->validation($request)['school_db'].'.student')
        ->select('username','password','usertypeID as user_type_id')
        ->where([['username',$this->validation($request)['username']],['password',$this->validation($request)['password']]])
        ->first();
        
        if($validate_auth == true)
        {
            $validate_auth->school_id = $request->school_id;
            return response()->json([
                'status' => '200',
                'message' => $validate_auth]);
        }
        else
        {
            return response()->json([
                'status' => '401',
                'message' => 'Unauthorized'], 401);
        }
    }

    public static function authorization(Request $request)
    {
        $username = $request->header('username');
        $password = $request->header('password');
        $user_type_id = $request->header('user_type_id');
        $school_db = DB::table('schooldb')
        ->select('database')
        ->where('schoolID',$request->header('school_id'))
        ->first();

        if($school_db == false)
        {
            return response()->json(['status' => 'Unauthorized'], 401);
        }
        
        $check_student_auth = DB::table($school_db->database.'.student')
        ->select('*')
        ->where([['username',$username],['password',$password],['usertypeID',$user_type_id]])
        ->first();

        $check_parent_auth = DB::table($school_db->database.'.parents')
        ->select('*')
        ->where([['username',$username],['password',$password],['usertypeID',$user_type_id]])
        ->first();

        if($check_student_auth == true)
        {
            return response()->json($check_student_auth);
        }
        elseif($check_parent_auth == true)
        {
            return response()->json($check_parent_auth);
        }
        else
        {
            return response()->json(['status' => 'Unauthorized'], 401);
        }
    }

    public static function example(Request $request)
    {
        $username = $request->header('username');
        $password = $request->header('password');
        $school_id = $request->header('school_id');
        
        return response()->json([
            'username' => $username,
            'password' => $password,
            'school_id' => $school_id,
        ]);
    }
}
