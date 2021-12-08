import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:async';

final userTable = 'userTable';

class DatabaseProvider {
  static DatabaseProvider _databaseProvider;
  static Database _database;

  DatabaseProvider._createInstance();

  factory DatabaseProvider() {
    if (_databaseProvider == null) {
      _databaseProvider = DatabaseProvider._createInstance();
    }
    return _databaseProvider;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'user.db';
    var noteDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
    return noteDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $userTable(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, '
        'token TEXT)');
  }
}
