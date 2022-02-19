import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_laravel_crud_app/services/storage.dart';
import 'package:http/http.dart' as http;

import '../models/token_model.dart';
import '../models/result_model.dart';

class AuthorizationApi {
  String baseUrl = "http://192.168.113.122:8000/api/";
  Future<TokenModel> register(String name, String email, String password,
      String confirmPassword) async {
    Map data = {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": confirmPassword
    };

    final response = await http.post(
      Uri.parse(baseUrl + "register"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      return TokenModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Sign Up Failed');
    }
  }

  Future<TokenModel> login(String email, String password) async {
    Map data = {"email": email, "password": password};

    debugPrint(data.toString());

    final response = await http.post(
      Uri.parse(baseUrl + "login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return TokenModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      return TokenModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Sign In Failed');
    }
  }

  Future<ResultModel> logout() async {
    final response = await http.post(
      Uri.parse(baseUrl + "logout"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${box.read('token')}',
      },
    );

    if (response.statusCode == 200) {
      return ResultModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Log out Failed');
    }
  }
}
