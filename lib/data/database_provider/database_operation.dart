import 'dart:async';

import 'package:flutter_app/data/database_provider/database_provider.dart';
import 'package:flutter_app/data/models/user.dart';

class DatabaseOperation {
  final DatabaseProvider databaseProvider = DatabaseProvider();

  Future<int> createUser(User user) async {
    final database = await databaseProvider.database;
    var result = await database.insert(userTable, user.toMap());
    return result;
  }

  Future<int> deleteUser(int id) async {
    final database = await databaseProvider.database;
    var result =
        await database.delete(userTable, where: "id=?", whereArgs: [id]);
    return result;
  }

  Future<bool> checkUser(int id) async {
    final database = await databaseProvider.database;
    try {
      List<Map> users =
          await database.query(userTable, where: "id=?", whereArgs: [id]);
      if (users.length != 0) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}
