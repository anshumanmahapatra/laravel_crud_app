<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class SampleController extends Controller
{
    public function sampleFunction() {
        return view('sample');
    }
}
