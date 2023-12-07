import 'package:sqflite/sqflite.dart';

import '../../model/cost_info.dart';

class CostInfoTable {
  /// INSERT
  void insertData(Database db, CostInfo costInfo) async {
    await db.insert('cost', costInfo.toMap());
  }

  /// DELETE
  void deleteData(Database db, String category) async {
    await db.delete('cost', where: "category = ?", whereArgs: [category]);
  }

  /// UPDATE
  void updateData(Database db, CostInfo costInfo) async {
    await db.update('cost', costInfo.toMap(), where: "category = ?", whereArgs: [costInfo.category]);
  }

  /// SELECT
  Future<List<Map>> queryList(Database db) async {
    return await db.rawQuery('SELECT * FROM cost;');
  }
}
