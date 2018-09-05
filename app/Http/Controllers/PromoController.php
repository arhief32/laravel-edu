<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Auth\AuthController as Auth;
use App\ResponseCode;
use Illuminate\Http\Request;

class PromoController extends Controller
{
    public function promo(Request $request)
    {
        $auth = Auth::authorization($request);

        if($auth == false)
        {
            return response()->json(ResponseCode::unauthorized());
        }
        else
        {
            // "SELECT * FROM `promo`;
            $result = DB::connection('school-gateway')->table('promo')->select('*')->get();
            
            return response()->json(ResponseCode::success($result));
        }
    }
}
