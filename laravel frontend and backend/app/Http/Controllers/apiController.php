<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use Illuminate\Support\Facades\DB;

use App\Models\Note;

class apiController extends Controller
{
    public function getNotesAPI() {
        $note = Note::all();
        return $note;
    }

    public function postNotesAPI(Request $request) {

        $note = new Note;
     
        $note->title = $request->title;
        $note->description = $request->description;
        $now = now();
        $note->created = $now;
        $response = $note->save();

        if($response) {
            return ["Result" => "Note was successfully saved"];
        } else {
           return ["Result" => "Note couldn't be saved"];
        }
    }

    public function putNotesAPI(Request $request) {
        $note = Note::find($request->id);

        $note->title = $request->title;
        $note->description = $request->description;
        $now = now();
        $note->created = $now;
        $response = $note->save();

        if($response) {
            return ["Result" => "Note was successfully updated"];
        } else {
           return ["Result" => "Note couldn't be updated"];
        }
    }

    public function deleteNotesAPI($id) {
        $note = Note::find($id);

        $response = $note->delete();

        if($response) {
            return [
                "Result" => "Note was successfully deleted"
            ];
        } else {
            return [
                "Result" => "Note couldn't be deleted"
            ];
        }
    }

    public function searchNotesAPI($name) {
        $response1 = Note::where("title", "like", "%".$name."%")->get();
        $response2 = Note::where("description", "like", "%".$name."%")->get();

        $emptyNote = new Note();

        if(!$response1->isEmpty()) {
            return $response1;
        } else if (!$response2->isEmpty()) {
            return $response2;
        } else {
            return $emptyNote;
        }
    }
}
