<?php

namespace App\Http\Controllers\Auth;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use App\ResponseCode;
use Carbon\Carbon;

class AuthController extends Controller
{
    /**
     * Populate school list before login
     */
    public function getSchool()
    {
        return response()->json(ResponseCode::success(
            DB::connection('school-gateway')->table('schooldb')
            ->select('schoolID as school_id','database as school_name')
            ->where('schoolID','<>','9999')
            ->get()));
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
     * Generate Token
     */
    public function generateToken()
    {
        $str = "";
        $chars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";	

        $length = 254;
        $size = strlen($chars);
        for($i=0; $i<$length; $i++) 
        {
	    	$str .= $chars[rand(0, $size-1)];
	    }

	    return $str;
    }

    public function checkToken($username, $school_id)
    {
        $token = DB::connection('school-gateway')->table('token')
        ->select('*')
        ->where([
            ['username',$username],
            ['schoolID',$school_id]
        ])
        ->first();

        if($token == true)
        {
            DB::connection('school-gateway')->table('token')
            ->where([['username',$username],['schoolID',$school_id]])
            ->update([
                'token' => $this->generateToken(),
                'refresh_date' => Carbon::now()
            ]);
        }
        else
        {
            DB::connection('school-gateway')->table('token')
            ->insert([
                'username' => $username,
                'schoolID' => $school_id,
                'token'=> $this->generateToken(),
                'create_date' => Carbon::now(),
                'refresh_date'=> Carbon::now()
            ]);
        }

        $token = DB::connection('school-gateway')->table('token')
        ->select('*')
        ->where([
            ['username',$username],
            ['schoolID',$school_id]
        ])
        ->first();

        return $token;
    }

    /**
     * login
     */
    public function login(Request $request)
    {
        // mengecek value dari login
        if($request->schoolID == '' || $request->username == '' || $request->password == '')
        {
            return response()->json(ResponseCode::login_failed());
        }

        // define value dari variable
        $school_db = $this->selectDatabase($request->schoolID);
        $username = $request->username;
        $password = $this->hash($request->password);

        $this->selectDatabase($request->header('schoolID'));
        
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
        ->select('username','password as token','usertypeID')
        ->where([['username',$username],['password',$password]])
        ->first();

        $validate_auth_parent = DB::table('parents')
        ->select('username','password as token','usertypeID')
        ->where([['username',$username],['password',$password]])
        ->first();
        
        // response
        if($validate_auth_student == true && $validate_auth_parent == false)
        {
            $token = $this->checkToken($username, $request->schoolID);     
            
            return response()->json(ResponseCode::login_success([
                'username' => $token->username,
                'token' => $token->token,
                'schoolID' => $token->schoolID,
                'userTypeID' => $validate_auth_student->usertypeID
            ]));
        }
        else if($validate_auth_student == false && $validate_auth_parent == true)
        {
            $token = $this->checkToken($username, $request->schoolID);     
            
            return response()->json(ResponseCode::login_success([
                'username' => $token->username,
                'token' => $token->token,
                'schoolID' => $token->schoolID,
                'userTypeID' => $validate_auth_parent->usertypeID
            ]));
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
        if($request->header('schoolID') == '' ||
        $request->header('username') == '' ||
        $request->header('token') == '' ||
        $request->header('userTypeID') == '')
        {
            return false;
        }

        // define variable
        $username = $request->header('username');
        $token = $request->header('token');
        $user_type_id = $request->header('userTypeID');
        $school_db = (new self)->selectDatabase($request->header('schoolID'));

        $select_token = DB::connection('school-gateway')->table('token')
        ->where([
            ['username', $username],
            ['token', $token]
        ])->first();

        // return $select_token;

        if($select_token == false)
        {
            return false;
        }
        else
        {
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
                return false;
            }
            
            $check_student_auth = '';
            $check_parent_auth = '';
            
            if($user_type_id == 3)
            {
                $check_student_auth = DB::table('student')
                ->select(
                    'studentID',
                    'name',
                    'dob',
                    'sex',
                    'religion',
                    'email',
                    'phone',
                    'address',
                    'classesID',
                    'sectionID',
                    'roll',
                    'bloodgroup',
                    'country',
                    'registerNO',
                    'state',
                    'library',
                    'hostel',
                    'transport',
                    'photo',
                    'parentID',
                    'createschoolyearID',
                    'schoolyearID',
                    'username',
                    'usertypeID',
                    'create_date',
                    'modify_date',
                    'create_userID',
                    'create_username',
                    'create_usertype',
                    'active'
                )
                ->where('username',$username)
                ->first();
            }
    
            if($user_type_id == 4)
            {
                $check_parent_auth = DB::table('parents')
                ->select(
                    'parentsID',
                    'name',
                    'father_name',
                    'mother_name',
                    'father_profession',
                    'mother_profession',
                    'email',
                    'phone',
                    'address',
                    'photo',
                    'username',
                    'usertypeID',
                    'create_date',
                    'modify_date',
                    'create_userID',
                    'create_username',
                    'create_usertype',
                    'active'
                )
                ->where('username',$username)
                ->first();
            }
    
            // response
            if($check_student_auth == true)
            {
                return $check_student_auth;
            }
            elseif($check_parent_auth == true)
            {
                return $check_parent_auth;
            }
            else
            {
                return false;
            }
        }

    }
}
