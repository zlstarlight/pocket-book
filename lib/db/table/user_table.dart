import 'package:sqflite/sqflite.dart';

import '../../model/user_info.dart';

class UserInfoTable {
  /// INSERT
  void insertData(Database db, UserInfo userInfo) async {
    await db.insert('user', userInfo.toMap());
  }

  /// DELETE
  void deleteData(Database db, String username) async {
    await db.delete('user', where: "username = ?", whereArgs: [username]);
  }

  /// UPDATE
  void updateData(Database db, UserInfo userInfo) async {
    await db.update('user', userInfo.toMap(), where: "username = ?", whereArgs: [userInfo.username]);
  }

  /// SELECT
  Future<List<Map>> queryList(Database db) async {
    return await db.rawQuery('SELECT * FROM user;');
  }
}
