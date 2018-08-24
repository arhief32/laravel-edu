<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\DB;

use Illuminate\Http\Request;

class StudentController extends Controller
{
    public function profile(Request $request)
    {
        $school_db = $request->school_id;
        $student = DB::table($school_db.'.student')->select('*')->first();
        return response()->json($student);
    }
}
