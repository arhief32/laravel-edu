<?php

namespace App;

use Laravel\Passport\HasApiTokens;
use Illuminate\Notifications\Notifiable;
use Illuminate\Foundation\Auth\User as Authenticatable;

class Student extends Authenticatable
{
    use HasApiTokens, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    
    protected $fillable = [
        // 'curency',
        // 'info_1',
        // 'info_2',
        // 'info_3',
        // 'info_4',
        // 'info_5',
        // 'bill_status',
        // 'briva_number',
        // 'bill_number',
        // 'bill_name',
        // 'bill_amount'
    	'studentID',						 	
        'name',	
        'dob',						 	
        'sex',							 	
        'religion',								 	
        'email',							 	
        'phone',							 	
        'address',						 	
        'classesID',						 	
        'sectionID',						 	
        'roll',					 	
        'bloodgroup',				 	
        'country',
        'register',				 	
        'state',				 	
        'library',					 	
        'hostel',						 	
        'transport',						 	
        'photo',		 	
        'parentID',							 	
        'createschoolyearID',							 	
        'schoolyearID',					 	
        'username',				 	
        'password',						 	
        'usertypeID',							 	
        'create_date',						 	
        'modify_date',						 	
        'create_userID',
        'create_username',				 	
        'create_usertype',			 	
        'active'
    ];

    public function changeConnection($connection){
        $this->connection = $connection;
    }
}
