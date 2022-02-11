<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class SampleController extends Controller
{   
    //Passing data to views through controller
    public function sampleFunction() {

        print_r("Route name is: ");
        print_r(route('view-through-controller'));

        $test = 'This line is also a sample';

        return view('sample', compact('test'));
    }

    //Passing data to views using Route parameters through Controller
    public function parameterFunction($name) {

        $data = [
            'iphone' => "iPhone",
            'samsung' => "Samsung",
            'realme' => "Realme",
            '9' => '9',
            '15' => '15',
        ];

        return view('sample', [
            'test' => $data[$name] ?? 'Product ' . $name . ' does not exist'
        ]);
    }

    public function goToNoAccess() {
        return view('noaccess');
    }

    public function forGroupMiddleware($middlewareName) {
        if(strcmp($middlewareName, 'groupMiddleware1') == 0) {
            return view('groupMiddleware');
        }
        if (strcmp($middlewareName, 'groupMiddleware2') == 0) {
            return view('groupMiddleware2');
        } 
    }

    public function forRouteMiddleware() {
        return view('routeMiddleware');
    }
}
