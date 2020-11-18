import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'agricolas.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;
  DatabaseHelper.internal();
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'agricolas.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE agricolas(id INTEGER PRIMARY KEY, tipo TEXT, marca TEXT, quantidade TEXT, preco TEXT)');
  }

  Future<int> insertAgriculas(Agricola agricolas) async {
    var dbClient = await db;
    var result = await dbClient.insert("agricolas", agricolas.toMap());
    return result;
  }

  Future<List> getAgriculass() async {
    var dbClient = await db;
    var result = await dbClient.query("agricolas", columns: ["id", "tipo", "marca", "quantidade", "preco"]);
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM agricolas'));
  }

  Future<Agricola> getAgriculas(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query("agricolas",
        columns: ["id", "nome", "tipo", "quantidade", "preco"],
        where: 'id = ?',
        whereArgs: [id]);
    if (result.length > 0) {
      return new Agricola.fromMap(result.first);
    }
    return null;
  }

  Future<int> deleteAgriculas(int id) async {
    var dbClient = await db;
    return await dbClient.delete("agricolas", where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateAgriculas(Agricola agricolas) async {
    var dbClient = await db;
    return await dbClient.update("agricolas", agricolas.toMap(),
        where: "id = ?", whereArgs: [agricolas.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}