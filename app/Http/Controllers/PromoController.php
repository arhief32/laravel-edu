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
            // $result = DB::connection('school-gateway')->table('promo')->select('*')
            // ->where('active', 1)
            // ->get();

            // $result_v2 = [];
            // foreach($result as $promo)
            // {
            //     array_push($result_v2, [
            //         'promoID' => $promo->promoID,
            //         'type' => $promo->type,
            //         'photo' => 'http://172.18.133.135:81/PUB_IMAGE/promo/'. strtolower($promo->type) . '/'.$promo->photo,
            //         'info' => $promo->info,
            //         'active' => $promo->active,
            //         'title' => $promo->title,
            //         'date' => $promo->date,
            //     ]);
            // }

            $client = new \GuzzleHttp\Client(['http_errors' => false]);
            $get_promos = $client->get(env('PROMO_URL').'/get-promo?platform_id=3')->getBody();
            $promos = json_decode($get_promos);
            $promos = $promos->responseData;
            
            $result = [];
            foreach($promos as $promo)
            {
                array_push($result, [
                    'promoID' => (integer)$promo->promo_id,
                    'type' => '',
                    'photo' => $promo->path_image,
                    'info' => $promo->description,
                    'active' => $promo->status,
                    'title' => $promo->title,
                    'date' => $promo->post_date,
                ]);
            }

            return response()->json(ResponseCode::success($result));
        }
    }
}
