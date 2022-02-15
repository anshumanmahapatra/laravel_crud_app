<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Note extends Model
{
    use HasFactory;
    public $timestamps = false;
    //Always remember to set the name of table in database as plural where the words starts with small letter
    //Also the name of the model Must start with capital letter and must be singular

    //If in case the table name is not plural then we have to provide the table name manually
    //So as to connect the table to our model

    //Suppose the table name is "employee"
    //And our model name is "Employee"
    //The below statement must be added
    //public $table = "employee";
}
