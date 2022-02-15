<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\HTTP;

use App\Models\Note;

class notesController extends Controller
{
    public function showData() {

        $allData = Note::all();
        $now = now();

        return view('dbView', ['data' => $allData, 'currentDateTime' => $now]);
    }

    public function showDataFromAPI() {
        $data = HTTP::get('https://reqres.in/api/users?page=1');

        return view('httpGetView', ['data' => $data['data']]);
    }

    public function addNote(Request $req) {
        $note = new Note;
    
        $note->title = $req->title;
        $note->description = $req->description;
        $now = now();
        $note->created = $now;
        $note->save();

        return redirect('/show-notes');
    }

    public function deleteNote($title) {
        $note = Note::find($title);
        $note->delete();
        return redirect('/show-notes');
    }

    public function showSpecificNote($id) {
        $note = Note::find($id);
        return view('updateNote', ["data" => $note]);
    }

    public function updateNote(Request $req) {
        $note = Note::find($req->id);
        $note->title = $req->title;
        $note->description = $req->description;
        $now = now();
        $note->created = $now;
        $note->save();

        return redirect('/show-notes');
    }
}
