<?php

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class StatusTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $status = [
            [
                'error_code' => '00',
                'description' => 'Sukses'
            ],
            [
                'error_code' => '01',
                'description' => 'No Tagihan harus ada'
            ],
            [
                'error_code' => '02',
                'description' => 'Data tagihan tidak ditemukan'
            ],
            [
                'error_code' => '03',
                'description' => 'Status pembayaran sudah lunas'
            ],
            [
                'error_code' => '04',
                'description' => 'Jumlah nominal pembayaran tidak sama dengan Total Tagihan'
            ],
            [
                'error_code' => '10',
                'description' => 'Koneksi Timeout'
            ],
            [
                'error_code' => '11',
                'description' => 'Tidak ada hak akses API'
            ],
            [
                'error_code' => '12',
                'description' => 'Koneksi ke API gagal'
            ],
            [
                'error_code' => '13',
                'description' => 'ID User aplikasi harus ada'
            ],
            [
                'error_code' => '14',
                'description' => 'Password aplikasi harus ada'
            ],
            [
                'error_code' => '20',
                'description' => 'Koneksi database timeout'
            ],
            [
                'error_code' => '21',
                'description' => 'Error query di database'
            ],
            [
                'error_code' => '99',
                'description' => 'Undefined'
            ]
        ];

        DB::table('status')->insert($status);
    }
}
