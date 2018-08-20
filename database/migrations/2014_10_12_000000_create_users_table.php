<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->increments('id');
            $table->string('currency');
            $table->string('info_1')->nullable();
            $table->string('info_2')->nullable();
            $table->string('info_3')->nullable();
            $table->string('info_4')->nullable();
            $table->string('info_5')->nullable();
            $table->string('bill_status');
            $table->string('briva_number');
            $table->string('bill_name');
            $table->string('bill_amount');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('users');
    }
}
