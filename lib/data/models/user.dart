import 'dart:convert';

class User {
  int id;
  String username;
  String token;
  User({
    this.id,
    this.username,
    this.token,
  });

  User copyWith({
    int id,
    String username,
    String token,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User(id: $id, username: $username, token: $token)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.username == username &&
        other.token == token;
  }

  @override
  int get hashCode => id.hashCode ^ username.hashCode ^ token.hashCode;
}
