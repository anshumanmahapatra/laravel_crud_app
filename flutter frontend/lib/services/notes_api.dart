import 'dart:convert';

import 'package:flutter_laravel_crud_app/services/storage.dart';
import 'package:http/http.dart' as http;

import '../models/note_model.dart';
import '../models/result_model.dart';

class NotesApi {
  String baseUrl = "http://192.168.113.122:8000/api/";
  Future<ResultModel> postNotesApi(String title, String description) async {
    Map data = {"title": title, "description": description};
    final response = await http.post(
      Uri.parse(baseUrl + "post-notes"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${box.read('token')}',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return ResultModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Sorry we could not add your note');
    }
  }

  Future<List<NoteModel>> getNotesApi() async {
    final response = await http.get(
      Uri.parse(baseUrl + "get-notes"),
      headers: <String, String>{
        'Authorization': 'Bearer ${box.read('token')}',
      },
    );

    if (response.statusCode == 200) {
      List result = jsonDecode(response.body);
      return NoteModel.getNotes(result);
    } else {
      throw Exception('Sorry we could not fetch the notes');
    }
  }

  Future<ResultModel> putNotesApi(
      int id, String title, String description) async {
    Map data = {
      "id": id.toString(),
      "title": title,
      "description": description
    };
    final response = await http.put(
      Uri.parse(baseUrl + "put-notes"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${box.read('token')}',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return ResultModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Sorry we could not update your note');
    }
  }

  Future<ResultModel> deleteNotesApi(String id) async {
    final response = await http.delete(
      Uri.parse(baseUrl + "delete-notes/$id"),
      headers: <String, String>{
        'Authorization': 'Bearer ${box.read('token')}',
      },
    );

    if (response.statusCode == 200) {
      return ResultModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Sorry we could not delete your note');
    }
  }

  Future<List<NoteModel>> searchNotesApi(String query) async {
    final response = await http.get(
      Uri.parse(baseUrl + "search-notes/$query"),
      headers: <String, String>{
        'Authorization': 'Bearer ${box.read('token')}',
      },
    );

    if (response.statusCode == 200) {
      List result = jsonDecode(response.body);
      return NoteModel.getNotes(result);
    } else {
      throw Exception('Sorry we could not fetch your query');
    }
  }
}
