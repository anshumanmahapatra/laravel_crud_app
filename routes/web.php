<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\SampleController;
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

//Route to test String
Route::get('/test-string', function () {
    return 'Hello World';
});

//Route to test json object
Route::get('/test-json-object', function () {
    return response()->json([
        'name' => 'Anshuman Mahapatra',
        'college' => 'VSSUT',
    ]);
});

//Route to test redirect
Route::get('/go-back', function () {
    return redirect('/');
});

//Route to show a view through controller
Route::get('/view-through-controller',[SampleController::class, 'sampleFunction'] );
