<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\apiController;

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

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

//Route for get Notes API
Route::get('/get-notes', [apiController::class, 'getNotesAPI']);

//Route for post Notes API
Route::post('/post-notes', [apiController::class, 'postNotesAPI']);

//Route for update Notes API
Route::put('/put-notes', [apiController::class, 'putNotesAPI']);

//Route for delete Notes API
Route::delete('/delete-notes/{id}', [apiController::class, 'deleteNotesAPI']);