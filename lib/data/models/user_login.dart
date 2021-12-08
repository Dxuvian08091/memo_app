import 'dart:convert';

import 'package:flutter/cupertino.dart';

class UserLogin {
  String username;
  String password;
  UserLogin({
    this.username,
    this.password,
  });

  UserLogin copyWith({
    String username,
    String password,
  }) {
    return UserLogin(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  factory UserLogin.fromMap(Map<String, dynamic> map) {
    return UserLogin(
      username: map['username'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLogin.fromJson(String source) =>
      UserLogin.fromMap(json.decode(source));

  @override
  String toString() => 'UserLogin(username: $username, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserLogin &&
        other.username == username &&
        other.password == password;
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode;
}

class Token {
  String token;
  Token({
    @required this.token,
  });

  Token copyWith({
    String token,
  }) {
    return Token(
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
    };
  }

  factory Token.fromMap(Map<String, dynamic> map) {
    return Token(
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Token.fromJson(String source) => Token.fromMap(json.decode(source));

  @override
  String toString() => 'Token(token: $token)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Token && other.token == token;
  }

  @override
  int get hashCode => token.hashCode;
}
