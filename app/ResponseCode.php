<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ResponseCode extends Model
{
    /**
     * Response Code for Authorization
     */
    public static function login_success($request)
    {
        return [
            'response_code' => '00',
            'description' => 'Login sukses',
            'data' => $request
        ];
    }

    public static function login_failed()
    {
        return [
            'response_code' => '01',
            'description' => 'Login gagal'
        ];
    }

    public static function unauthorized()
    {
        return [
            'response_code' => '11',
            'description' => 'Tidak ada hak akses'
        ];
    }

    public static function authorized($request)
    {
        return [
            'response_code' => '00',
            'description' => 'sukses',
            'data' => $request
        ];
    }
}
