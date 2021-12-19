import 'package:flutter/material.dart';
import 'package:time_tracker/providers/db_provider.dart';

class DbUtils{

  final String tableName;

  DbUtils({@required this.tableName});

  // INSERT OPERATIONS

  Future<int> save(Map<String, dynamic> data) async {
    final db = await DBProvider.db.database;
    int id = await db.insert(tableName, data);
    return id;
  }

  // GET OPERATIONS

  findAll() async {
    final db = await DBProvider.db.database;
    var res = await db.query(tableName);
    return res.isNotEmpty ? res : [] ;
  }

  findByFieldId(String fieldName, int fieldId) async {
    final db = await DBProvider.db.database;
    var res = await db.query(
      tableName,
      where: "$fieldName = ?",
      whereArgs: [fieldId]
    );
    return res.isNotEmpty ? res : [];
  }

  Future<Map<String, dynamic>> findById(int id) async {
    final db = await DBProvider.db.database;
    var res =await  db.query(tableName, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? res.first : null ;
  }

  // UPDATE OPERATIONS

  Future<int> updateById(int id, Map<String, dynamic> data) async {
    final db = await DBProvider.db.database;
    await db.update(tableName, data,
        where: "id = ?", whereArgs: [id]);
    return id;
  }

  // DELETE OPERATIONS

  Future<void> deleteById(int id, {String fieldName: "id"}) async {
    final db = await DBProvider.db.database;
    await db.delete(tableName, where: "$fieldName = ?", whereArgs: [id]);
  }

  Future<void> deleteAll() async {
    final db = await DBProvider.db.database;
    await db.delete(tableName);
  }
}