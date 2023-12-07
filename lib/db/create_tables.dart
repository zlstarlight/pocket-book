import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CreateTables {
  late Database db;

  final String user = '''
    CREATE TABLE IF NOT EXISTS user(
      username varchar(255) not null,
      password varchar(255) not null);
    ''';

  final String cost = '''
    CREATE TABLE IF NOT EXISTS cost(
      category INTEGER not null,
      count varchar(255),
      date varchar(255) not null,
      tips varchar(255));
    ''';

  Future<Database> init() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'pocket_book.db');

    try {
      db = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
        await db.execute(user);
        await db.execute(cost);
      });
    } catch (e) {
      debugPrint('CreateTables init Error $e');
    }
    return db;
  }
}
