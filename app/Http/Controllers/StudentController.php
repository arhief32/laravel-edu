<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Auth\AuthController as Auth;

use Illuminate\Http\Request;

class StudentController extends Controller
{
    public function profile(Request $request)
    {
        return Auth::authorization($request);
    }
}
