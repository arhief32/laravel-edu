<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

class AddTokenApiToStudent extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    
    // public function up()
    // {
    //     $databases = DB::table('schooldb')->select('database')->get();
        
    //     foreach($databases as $database)
    //     {
    //         Schema::table($database->database.'.student', function (Blueprint $table) {
    //             $table->string('api_token', 100)->unique();
    //         });
    //     }
    // }

    // /**
    //  * Reverse the migrations.
    //  *
    //  * @return void
    //  */
    // public function down()
    // {
    //     $databases = DB::table('schooldb')->select('database')->get();
        
    //     foreach($databases as $database)
    //     {
    //         Schema::table($database->database.'.student', function (Blueprint $table) {
    //             $table->string('api_token', 100)->unique();
    //         });
    //     }
    // }
}
