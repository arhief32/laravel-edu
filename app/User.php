<?php

namespace App;

use Illuminate\Notifications\Notifiable;
use Illuminate\Foundation\Auth\User as Authenticatable;

class User extends Authenticatable
{
    use Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    
    protected $table = 'users';
    
    protected $fillable = [
        'curency',
        'info_1',
        'info_2',
        'info_3',
        'info_4',
        'info_5',
        'bill_status',
        'briva_number',
        'bill_number',
        'bill_name',
        'bill_amount'
    ];

    public function status()
    {
        return $this->belongsTo('App\Status','status_id','error_code');
    }
}
