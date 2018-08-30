<?php

namespace App\Http\Controllers\Auth;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use App\ResponseCode;

class AuthController extends Controller
{
    /**
     * Populate school list before login
     */
    public function getSchool()
    {
        return response()->json(ResponseCode::success(
            DB::connection('school-gateway')->table('schooldb')->select('schoolID as school_id','database as school_name')->get()));
    }
    
    public function selectDatabase($school_id)
    {
        return DB::connection('school-gateway')->table('schooldb')
        ->select('*')
        ->where('schoolID',$school_id)
        ->first();
    }

    /**
     * Enkripsi password
     */
    public function hash($string) 
    {
		return hash("sha512",$string."ceca0623e7992c1620c7372408b6f41d");
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

        // define value dari variable
        $school_db = $this->selectDatabase($request->school_id);
        $username = $request->username;
        $password = $this->hash($request->password);

        // modify database select dynamically
        config(['database.connections.mysql' => [
            'driver' => 'mysql',
            'host' => $school_db->hostname,
            'database' => $school_db->database,
            'username' => $school_db->username,
            'password' => $school_db->password
        ]]);

        // mencari dan mencocokkan value ke database
        $validate_auth_student = DB::table('student')
        ->select('username','password','usertypeID as user_type_id')
        ->where([['username',$username],['password',$password]])
        ->first();

        $validate_auth_parent = DB::table('parents')
        ->select('username','password','usertypeID as user_type_id')
        ->where([['username',$username],['password',$password]])
        ->first();
        
        // response
        if($validate_auth_student == true && $validate_auth_parent == false)
        {
            $validate_auth_student->school_id = $request->school_id;
            
            return response()->json(ResponseCode::login_success($validate_auth_student));
        }
        else if($validate_auth_student == false && $validate_auth_parent == true)
        {
            $validate_auth_parent->school_id = $request->school_id;
            
            return response()->json(ResponseCode::login_success($validate_auth_parent));
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
        $school_db = (new self)->selectDatabase($request->header('school_id'));
        
        // modify database connection dynamically
        config(['database.connections.mysql' => [
            'driver' => 'mysql',
            'host' => $school_db->hostname,
            'database' => $school_db->database,
            'username' => $school_db->username,
            'password' => $school_db->password
        ]]);

        // validasi auth
        if($school_db == false)
        {
            return response()->json(ResponseCode::unauthorized());
        }
        
        $check_student_auth = DB::table('student')
        ->select('*')
        ->where([['username',$username],['password',$password],['usertypeID',$user_type_id]])
        ->first();

        $check_parent_auth = DB::table('parents')
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

    // public function example(Request $request)
    // {
    //     $school_db = DB::connection('school-gateway')->table('schooldb')
    //     ->select('*')
    //     ->where('schoolID',$request->school_id)
    //     ->first();

    //     config(['database.connections.mysql' => [
    //         'driver' => 'mysql',
    //         'host' => $school_db->hostname,
    //         'database' => $school_db->database,
    //         'username' => $school_db->username,
    //         'password' => $school_db->password
    //     ]]);

	// 	return DB::table('student')->select('*')->get();
    // }
}
