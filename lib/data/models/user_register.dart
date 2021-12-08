import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserRegister {
  String username;
  String password;
  String password2;
  String email;
  List notes;
  UserRegister({
    @required this.username,
    @required this.password,
    @required this.password2,
    @required this.email,
    @required this.notes,
  });

  UserRegister copyWith({
    String username,
    String password,
    String password2,
    String email,
    List notes,
  }) {
    return UserRegister(
      username: username ?? this.username,
      password: password ?? this.password,
      password2: password2 ?? this.password2,
      email: email ?? this.email,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'password2': password2,
      'email': email,
      'notes': notes,
    };
  }

  factory UserRegister.fromMap(Map<String, dynamic> map) {
    return UserRegister(
      username: map['username'],
      password: map['password'],
      password2: map['password2'],
      email: map['email'],
      notes: List.from(map['notes']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRegister.fromJson(String source) =>
      UserRegister.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserRegister(username: $username, password: $password, password2: $password2, email: $email, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserRegister &&
        other.username == username &&
        other.password == password &&
        other.password2 == password2 &&
        other.email == email &&
        listEquals(other.notes, notes);
  }

  @override
  int get hashCode {
    return username.hashCode ^
        password.hashCode ^
        password2.hashCode ^
        email.hashCode ^
        notes.hashCode;
  }
}
