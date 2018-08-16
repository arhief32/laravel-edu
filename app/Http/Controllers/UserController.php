<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\User;

class UserController extends Controller
{
    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($briva_number)
    {
        $result = User::where('briva_number',$briva_number)->first();
        
        return response()->json($result);
    }
}
