<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\SampleController;
use App\Http\Controllers\notesController;

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

//Route to no access page
Route::get('/noaccess', [SampleController::class, 'goToNoAccess']);

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
// Route::get('/view-through-controller',[SampleController::class, 'sampleFunction'] );

//Passing arguments to routes as number
Route::get('view-through-controller/{id}', [SampleController::class, 'parameterFunction'])->where('id', '[0-9]+')->name('view-through-controller-id');

//Passing arguments to routes as string
Route::get('/view-through-controller/{name}', [SampleController::class, 'parameterFunction'])->where('name', '[a-zA-Z]+');

//Passing multiple arguments to routes
Route::get('/view-through-controller/{name}/{id}', [SampleController::class, 'parameterFunction'])->where([
    'name' => '[a-zA-Z]+',
    'id' => '[0-9]+',
]);

//Named Routes
Route::get('/view-through-controller',[SampleController::class, 'sampleFunction'] )->name('view-through-controller');

//Group middleware example
Route::group(['middleware' => ['groupMiddleware']], function () {
    Route::get('/view-through-controller/{middlewareName}',[SampleController::class, 'forGroupMiddleware'] );
});

//Route middleware example
Route::get('middleware/routeMiddleware',[SampleController::class, 'forRouteMiddleware'] )->middleware('routeMiddleware');

//Route to show notes from DB
Route::get('/show-notes', [notesController::class, 'showData']);

//Route to show data from API
Route::get('/show-data-from-API', [notesController::class, 'showDataFromAPI']);

//Route to add new Note
Route::view('/add-note', 'addNote');

//Route for submitting the new Note
Route::post('/add-note', [notesController::class, 'addNote']);

//Route for deleting a Note
Route::get('/delete-note/{id}', [notesController::class , 'deleteNote']);

//Route to update a Note
Route::get('/update-note/{id}', [notesController::class, 'showSpecificNote']);

//Route for submitting the updated Route
Route::post('/update-note', [notesController::class, 'updateNote']);

