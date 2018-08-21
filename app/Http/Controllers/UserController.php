<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\User;

class UserController extends Controller
{
    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function request($briva_number)
    {
        $school_id = substr($briva_number, 5, 4);
        $school_db = DB::connection('school-gateway')->table('schoolgateway.schooldb')->select('*')->where('schoolID',$school_id)->first();
        
        return response()->json($school_db);
    }
}
