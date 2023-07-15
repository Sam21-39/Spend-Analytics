import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DbHelper {
  // DATABASE STATICS
  static final _dbName = "_spendigsTable.db";
  static final _dbVersion = 2; // new version
  static final _tableName = "_spendings";
  static final _columnId = "_id";
  static final _columnAmount = "_amount";
  static final _columnType = "_type";
  static final _columnMode = "_mode";
  static final _columnDateTime = "_datetime";
  static final _columnDescription = "_description";

  // DATABASE CONSTRUCTION
  DbHelper._();
  static final DbHelper dbInstance = DbHelper._();

  static Database? _database;

  // GETTING THE DATABASE
  Future<Database?> get databse async {
    _database = await initiateDb();
    return _database;
  }

  // DATABASE INITIALIZATION
  Future initiateDb() async {
    Directory _directory = await getApplicationDocumentsDirectory();
    String _path = join(_directory.path, _dbName);
    return await openDatabase(
      _path,
      version: _dbVersion,
      onCreate: _onCreationOfDb,
    );
  }

  // DATABASE CREATION
  Future _onCreationOfDb(Database db, int version) async {
    return await db.execute(
      '''
      CREATE TABLE $_tableName(
        $_columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $_columnAmount INTEGER NOT NULL,
        $_columnType TEXT NOT NULL,
        $_columnDateTime TEXT NOT NULL,
        $_columnMode TEXT NOT NULL,
        $_columnDescription TEXT)
      '''
          .trim(),
    );
  }

  // DATABASE INSERT ROW
  Future<int?> insert(Map<String, dynamic> row) async {
    Database? db = await dbInstance.databse;
    return await db?.insert(_tableName, row);
  }

  // DATABASE QUERY FETCH ALL ROW
  Future<List<Map<String, dynamic>>?> queryAll() async {
    Database? db = await dbInstance.databse;
    return await db?.query(
      _tableName,
      orderBy: "$_columnId DESC",
    );
  }

  // DATABASE QUERY FETCH SELECTED ROW
  Future<List<Map<String, dynamic>>?> querySelected(String month,
      {String? year}) async {
    Database? db = await dbInstance.databse;
    return await db?.query(
      _tableName,
      where: "$_columnDateTime LIKE ? ORDER BY $_columnId DESC",
      whereArgs: ["%/$month/$year"],
    );
  }

  // DATABASE UPDATE ROW
  Future<int?> update(Map<String, dynamic> row) async {
    Database? db = await dbInstance.databse;
    int? id = row[_columnId];
    return await db?.update(
      _tableName,
      row,
      where: "$_columnId = ?",
      whereArgs: [id],
    );
  }

  // DATABASE DELETE ROW
  Future<int?> delete(int? id) async {
    Database? db = await dbInstance.databse;
    return await db?.delete(
      _tableName,
      where: "$_columnId = ?",
      whereArgs: [id],
    );
  }
}
