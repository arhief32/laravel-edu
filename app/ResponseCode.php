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

    public static function failed()
    {
        return [
            'responseCode' => '01',
            'responseDesc' => 'Gagal'
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

    public static function brivaNotFound($status_code, $request)
    {
        return [
            'responseCode' => $status_code,
            'responseDesc' => 'Tagihan tidak ditemukan',
            'responseData' => $request,
        ];
    }

    public static function brivaInquirySuccess($request)
    {
        return [
            'responseCode' => '0',
            'responseDesc' => 'Inquiry Success',
            'responseData' => $request,
        ];
    }

    public static function brivaPaymentNotMatch($request)
    {
        return [
            'responseCode' => '04',
            'responseDesc' => 'Jumlah nominal pembayaran tidak sama dengan total tagihan',
            'responseData' => $request,
        ];
    }

    public static function brivaPaymentSuccess($request)
    {
        return [
            'responseCode' => '00',
            'responseDesc' => 'Transaction Success',
            'responseData' => $request,
        ];
    }
}
