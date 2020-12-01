import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DbHelper {
  // DATABASE STATICS
  static final _dbName = "spendigsTable.db";
  static final _dbVersion = 1;
  static final _tableName = "spendings";
  static final _columnId = "_id";
  static final _columnAmount = "_amount";
  static final _columnType = "_type";
  static final _columnDateTime = "_datetime";
  static final _columnDescription = "_description";

  // DATABASE CONSTRUCTION
  DbHelper._privateConstructor();
  static final DbHelper dbInstance = DbHelper._privateConstructor();

  static Database _database;

  // GETTING THE DATABASE
  Future<Database> get databse async {
    if (_database != null) return _database;

    _database = await initiateDb();
    return _database;
  }

  // DATABASE INITIALIZATION
  Future initiateDb() async {
    Directory _directory = await getApplicationDocumentsDirectory();
    String _path = join(_directory.path, _dbName);
    await openDatabase(_path, version: _dbVersion, onCreate: _onCreationOfDb);
  }

  // DATABASE CREATION
  Future _onCreationOfDb(Database db, int version) async {
    db.execute('''
      CREATE TABLE $_tableName (
        $_columnId INTEGER PRIMARY KEY,
        $_columnAmount INTEGER NOT NULL,
        $_columnType TEXT NOT NULL,
        $_columnDateTime TEXT NOT NULL,
        $_columnDescription TEXT,
      )
      ''');
  }

  // DATABASE INSERT ROW
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await dbInstance.databse;
    return db.insert(_tableName, row);
  }

  // DATABASE QUERY FETCH ALL ROW
  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await dbInstance.databse;
    return db.query(_tableName);
  }

  // DATABASE QUERY FETCH SELECTED ROW
  Future<List<Map<String, dynamic>>> querySelected(
      Map<String, dynamic> row) async {
    Database db = await dbInstance.databse;
    String dateTime = row[_columnDateTime];
    return db.query(
      _tableName,
      where: "$_columnDateTime = ?",
      whereArgs: [dateTime],
    );
  }

  // DATABASE UPDATE ROW
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await dbInstance.databse;
    int id = row[_columnId];
    return db.update(
      _tableName,
      row,
      where: "$_columnId = ?",
      whereArgs: [id],
    );
  }

  // DATABASE DELETE ROW
  Future<int> delete(int id) async {
    Database db = await dbInstance.databse;
    return db.delete(
      _tableName,
      where: "$_columnId = ?",
      whereArgs: [id],
    );
  }
}
