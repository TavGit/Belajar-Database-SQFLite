import 'dart:io';

import 'package:belajar_sqflite/database/productmodel_instance.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseInstance {
  final String _databaseName = 'my_database.db';
  final int _databaseVersion = 1;

  // PRODUK TABLE

  final String table = 'produk';
  final String id = 'id';
  final String name = 'name';
  final String category = 'category';
  final String createdAt = 'created_at';
  final String updatedAt = 'updated_at';

  Database? _database;

  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return database();
  }

  Future _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    return db.execute(
      'CREATE TABLE $table ($id INTEGER PRIMARY KEY, $name TEXT, $category TEXT, $createdAt TEXT, $updatedAt TEXT)',
    );
  }

  Future<List<ProductModel>> all() async {
    final data = await _database!.query(table);
    List<ProductModel> result =
        data.map((e) => ProductModel.fromJson(e)).toList();
    print(result);
    return result;
  }

  Future<int> insert(Map<String, dynamic> row) async {
    final query = _database!.insert(table, row);
    return query;
  }

  Future<int> update(int idParam, Map<String, dynamic> row) async {
    final query = await _database!.update(
      table,
      row,
      where: '${id} = ? ',
      whereArgs: [idParam],
    );
    return query;
  }

  Future<int> delete(int idParam) async {
    await _database!.delete(table, where: '${id} = ?', whereArgs: [idParam]);
    return idParam;
  }
}
