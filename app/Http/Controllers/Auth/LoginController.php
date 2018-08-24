<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class LoginController extends Controller
{
    public function hash($string) 
    {
		return hash("sha512", $string . "ceca0623e7992c1620c7372408b6f41d");
    }
    
    /*
    |--------------------------------------------------------------------------
    | Login Controller
    |--------------------------------------------------------------------------
    |
    | This controller handles authenticating users for the application and
    | redirecting them to your home screen. The controller uses a trait
    | to conveniently provide its functionality to your applications.
    |
    */

    use AuthenticatesUsers;

    /**
     * Where to redirect users after login.
     *
     * @var string
     */
    protected $redirectTo = '/home';

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('guest')->except('logout');
    }

    public function login(Request $request)
    {
        $username = $request->username;
        $password = $this->hash($request->password);
        $school_db = $request->school_db;

        $validate_username = DB::table($school_db.'.student')->select('username','password')
        ->where([['username',$username],['password',$password]])
        ->first();

        
        if($validate_username == true)
        {
            return response()->json($validate_username);
        }
        else
        {
            return response()->json(['status' => 'Unauthorized'], 401);
        }
    }
}
