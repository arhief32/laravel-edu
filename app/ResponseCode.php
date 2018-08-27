<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ResponseCode extends Model
{
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
}
