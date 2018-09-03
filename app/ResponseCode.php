<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ResponseCode extends Model
{
    /**
     * Response Code for Authorization
     */
    public static function success($request)
    {
        return [
            'responseCode' => '00',
            'responseDesc' => 'Success',
            'responseData' => $request
        ];
    }

    public static function failed($request)
    {
        return [
            'responseCode' => '01',
            'responseDesc' => 'Gagal',
            'responseData' => $request
        ];
    }
    
    public static function login_success($request)
    {
        return [
            'responseCode' => '00',
            'responseDesc' => 'Login sukses',
            'responseData' => $request
        ];
    }

    public static function login_failed()
    {
        return [
            'responseCode' => '01',
            'responseDesc' => 'Login gagal'
        ];
    }

    public static function unauthorized()
    {
        return [
            'responseCode' => '11',
            'responseDesc' => 'Tidak ada hak akses'
        ];
    }

    public static function authorized($request)
    {
        return [
            'responseCode' => '00',
            'responseDesc' => 'sukses',
            'responseData' => $request
        ];
    }
}
