import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/data/api_connection/api_connection.dart';
import 'package:flutter_app/data/database_provider/database_operation.dart';
import 'package:flutter_app/data/models/user.dart';
import 'package:flutter_app/data/models/user_login.dart';
import 'package:flutter_app/data/models/user_register.dart';

class UserRepository {
  final databaseOperation = DatabaseOperation();

  Future<User> authenticate(
      {@required String username, @required String password}) async {
    UserLogin userLogin = UserLogin(username: username, password: password);
    Token token = await getToken(userLogin);
    User user = User(id: 0, username: username, token: token.token);
    return user;
  }

  Future<void> register({@required UserRegister userRegister}) async {
    debugPrint('register ${userRegister.toString()}');
    await registerUser(userRegister);
  }

  Future<void> persistToken({@required User user}) async {
    await databaseOperation.createUser(user);
  }

  Future<void> deleteToken({@required int id}) async {
    await databaseOperation.deleteUser(id);
  }

  Future<bool> hasToken() async {
    bool result = await databaseOperation.checkUser(0);
    return result;
  }
}
