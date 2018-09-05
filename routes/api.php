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

Route::get('/request-inquiry','InvoiceController@requestInquiry');
Route::post('/request-payment','InvoiceController@requestPayment');
Route::get('/example','InvoiceController@example');

/**
 * Apps
 */

Route::get('/get-school','Auth\AuthController@getSchool');
Route::post('/login','Auth\AuthController@login');

/**
 * Student
 */
Route::prefix('/student')->group(function(){
    Route::get('/profile','StudentController@profile');
    Route::get('/teacher','TeacherController@getTeacher');

    // Academic
    Route::prefix('/academic')->group(function(){
        Route::get('/subject','AcademicController@getSubject');
        Route::get('/assignment','AcademicController@getAssignment');
        Route::get('/routine','AcademicController@getRoutine');
    });

    // Student Attendance
    Route::get('/student-attendance','AttendanceController@studentAttendance');

    // Exam Schedule
    Route::get('/exam-schedule');

    // Mark
    Route::get('/mark');

    // Promo
    Route::get('/promo','PromoController@promo');

    // Account
    Route::prefix('/account')->group(function(){
        Route::get('/invoice');
        Route::get('/payment-history');
    });

    // Announcement
    Route::prefix('/announcement')->group(function(){
        Route::get('/notice','AnnouncementController@getNotice');
        Route::get('/event','AnnouncementController@getEvent');
        Route::get('/holiday','AnnouncementController@getHoliday');
    });
});

/**
 * Parent
 */
Route::prefix('/parent')->group(function(){
    Route::get('/profile','ParentController@profile');
    Route::get('/teacher','TeacherController@getTeacher');

    // Academic
    Route::prefix('/academic')->group(function(){
        Route::get('/subject','AcademicController@getSubject');
        Route::get('/syllabus','AcademicController@getSyllabus');
        Route::get('/routine','AcademicController@getRoutine');
    });

    // Student Attendance
    Route::get('/student-list','AttendanceController@studentList');
    Route::get('/student-attendance','AttendanceController@studentAttendanceParent');

    // Exam Schedule
    Route::get('/exam-schedule');

    // Mark
    Route::get('/mark');

    // Promo
    Route::get('/promo','PromoController@promo');

    // Account
    Route::prefix('/account')->group(function(){
        Route::get('/invoice');
        Route::get('/payment-history');
    });

    // Announcement
    Route::prefix('/announcement')->group(function(){
        Route::get('/notice','AnnouncementController@getNotice');
        Route::get('/event','AnnouncementController@getEvent');
        Route::get('/holiday','AnnouncementController@getHoliday');
    });
});




Route::post('example','Auth\AuthController@example');
