<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class RegistrationController extends Controller
{
    /**
     * Encrypt/Decrypt password
     */
    public static function encrypt_decrypt($action, $string)
    {
        $output = false;
        $encrypt_method = "AES-256-CBC";
        $secret_key = 'ceca0623e7992c1620c7372408b6f41d';
        $secret_iv = 'S3cr3tP@ssw0rdBRIEDUPEPKJT';
        $key = hash('sha256', $secret_key);    
        $iv = substr(hash('sha256', $secret_iv), 0, 16);
        
        if($action == 'encrypt') 
        {
            $output = openssl_encrypt($string, $encrypt_method, $key, 0, $iv);
            $output = base64_encode($output);

            return $output;
        } 
        else if( $action == 'decrypt')
        {
            $output = openssl_decrypt(base64_decode($string), $encrypt_method, $key, 0, $iv);
            $output = explode('|',$output);
            $output = $output[1];

            return $output;
        }
    }

    public function register(Request $request)
    {
        $corporate_code = $request->corporate_code;
        $nama_company = $request->nama_company;
        $nama = $request->nama;
        $telepon = $request->telepon;
        $email = $request->email;
        $nomor_rekening = $request->nomor_rekening;
        $nama_rekening = $request->nama_rekening;

        // newSchoolID = select schoolID + 1 from schooldb where schoolID != '9999' order by schoolID desc limit 1
        $get_school_id = DB::connection('school-gateway')->table('schooldb')->select('schoolID')
        ->where('schoolID', '!=', '9999')
        ->orderBy('schoolID', 'DSC')
        ->first();

        $get_school_id = substr('0000'.((string)((int)$get_school_id->schoolID + 1)), -4);

        // INSERT INTO `schoolgateway`.`schooldb`								
        // (`schoolID`, `hostname`, `username`, `password`, `database`, `brivaNo`, `schoolName`)								
        // VALUES								
        // ([newSchoolID], '172.18.133.135', 'smartschool', hash([newSchoolID]|P@ssw0rd), 'school'.[newSchoolID], [corporate_code], [nama_company]);
        $insert_data = DB::connection('school-gateway')->table('schooldb')->insert([
            'schoolID' => $get_school_id,
            'hostname' => '172.18.133.135',
            'username' => 'smartschool',
            'password' => $this->encrypt_decrypt('encrypt', $get_school_id.'|P@ssw0rd'),
            'database' => 'school'.$get_school_id,
            'brivaNo' => $corporate_code,
            'schoolName' => $nama_company,
        ]);

        return $insert_data == true ? 
        response()->json([
            'status' => 'success',
            'message' => [
                'corporate_code' => $get_school_id
            ]
        ])
        :
        response()->json([
            'status' => 'gagal'
        ]);
    }
}
