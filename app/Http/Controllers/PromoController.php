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
            $result = DB::connection('school-gateway')->table('promo')->select('*')
            ->where('active', 1)
            ->get();

            $result_v2 = [];
            foreach($result as $promo)
            {
                array_push($result_v2, [
                    'promoID' => $promo->promoID,
                    'type' => $promo->type,
                    'photo' => 'http://'.$_SERVER['HTTP_HOST'].'/PUB_IMAGE/promo/'.$promo->type.'/'.$promo->photo,
                    'info' => $promo->info,
                    'active' => $promo->active,
                    'title' => $promo->title,
                    'date' => $promo->date,
                ]);
            }
            
            return response()->json(ResponseCode::success($result_v2));
        }
    }
}
