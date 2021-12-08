import 'dart:convert';
import 'package:flutter_app/data/models/user_login.dart';
import 'package:flutter_app/data/models/user_register.dart';
import 'package:http/http.dart' as http;

String _base = "https://remappx.herokuapp.com";
String _tokenEndpoint = "/api/token/";
String _userEndpoint = '/users/';
String _tokenUrl = _base + _tokenEndpoint;
String _userUrl = _base + _userEndpoint;

//returns a token when getToken method is called
Future<Token> getToken(UserLogin userLogin) async {
  final http.Response response = await http.post(Uri.parse(_tokenUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: userLogin.toJson());
  if (response.statusCode == 200) {
    return Token.fromJson(response.body);
  } else {
    throw Exception(json.decode(response.body));
  }
}

//registers a user when registerUser method is called
Future<String> registerUser(UserRegister userRegister) async {
  final http.Response response = await http.post(Uri.parse(_userUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: userRegister.toJson());
  if (response.statusCode == 200 || response.statusCode == 201) {
    return json.decode(response.body).toString();
  } else {
    throw Exception(json.decode(response.body));
  }
}
