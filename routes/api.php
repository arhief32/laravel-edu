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
Route::post('/registration-company','RegistrationController@register');
Route::get('/rollback-company','RegistrationController@deleteRegister');

Route::post('/request-inquiry','InvoiceController@requestInquiry');
Route::post('/request-payment','InvoiceController@requestPayment');

/**
 * Apps
 */

Route::get('/get-school','Auth\AuthController@getSchool');
Route::post('/login','Auth\AuthController@login');

/**
 * Student
 */
Route::prefix('/student')->middleware('student')->group(function(){
    Route::get('/profile','StudentController@profile');
    Route::get('/teacher','TeacherController@getTeacher');

    // Academic
    // Route::prefix('/academic')->group(function(){
        Route::get('/subject','AcademicController@getSubject');
        Route::get('/assignment','AcademicController@getAssignment');
        Route::get('/routine','AcademicController@getRoutine');
    // });

    // Student Attendance
    Route::get('/student-attendance','AttendanceController@studentAttendance');

    // Exam Schedule
    Route::get('/exam-schedule','ExamController@getExamSchedule');
    Route::get('/exam-mark','ExamController@getExamMark');

    // Promo
    Route::get('/promo','PromoController@promo');

    // Account
    // Route::prefix('/account')->group(function(){
        Route::get('/invoice','AccountController@getInquiryInvoice');
        Route::get('/payment-history','AccountController@getPaymentHistory');
    // });

    // Announcement
    // Route::prefix('/announcement')->group(function(){
        Route::get('/notice','AnnouncementController@getNotice');
        Route::get('/event','AnnouncementController@getEvent');
        Route::post('/flag-event','AnnouncementController@flagEvent');
        Route::get('/holiday','AnnouncementController@getHoliday');
    // });
});

/**
 * Parent
 */
Route::prefix('/parent')->middleware('parent')->group(function(){
    Route::get('/profile','ParentController@profile');
    Route::get('/teacher','TeacherController@getTeacher');

    // Academic
    // Route::prefix('/academic')->group(function(){
        Route::get('/subject','AcademicController@getSubject');
        Route::get('/syllabus','AcademicController@getSyllabus');
        Route::get('/routine','AcademicController@getRoutine');
    // });

    // Student Attendance
    Route::get('/student-list','AttendanceController@studentList');
    Route::get('/student-attendance','AttendanceController@studentAttendanceParent');

    // Exam Schedule
    Route::get('/exam-schedule','ExamController@getExamSchedule');
    Route::get('/exam-mark','ExamController@getExamMark');

    // Promo
    Route::get('/promo','PromoController@promo');

    // Account
    // Route::prefix('/account')->group(function(){
        Route::get('/invoice','AccountController@getInquiryInvoice');
        Route::get('/payment-history','AccountController@getPaymentHistory');
    // });

    // Announcement
    // Route::prefix('/announcement')->group(function(){
        Route::get('/notice','AnnouncementController@getNotice');
        Route::get('/event','AnnouncementController@getEvent');
        Route::post('/flag-event','AnnouncementController@flagEvent');
        Route::get('/holiday','AnnouncementController@getHoliday');
    // });
});







/**
 * NOTIFICATION EXAMPLE
 */
Route::get('example-notification','NotificationController@exampleNotification');