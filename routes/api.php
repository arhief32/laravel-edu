<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('/get-user-detail/{id}','UserController@request');

Route::post('/login','Auth\AuthController@login');

Route::prefix('/student')->group(function(){
    Route::get('/profile','StudentController@profile');
});

Route::prefix('/parent')->group(function(){
    Route::get('/profile','ParentController@profile');
});
