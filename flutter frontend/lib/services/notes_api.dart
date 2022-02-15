import 'dart:convert';
import 'package:flutter_laravel_crud_app/models/note_model.dart';
import 'package:http/http.dart' as http;

class NotesApi {
  Future<List<NoteModel>> getNotesApi() async {
    final response = await http.get(
      Uri.parse("http://192.168.235.122:8000/api/get-notes"),
    );

    if (response.statusCode == 200) {
      List result = jsonDecode(response.body);
      return NoteModel.getNotes(result);
    } else {
       throw Exception('Sorry we could not fetch your query');
    }
  }
}
