import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sau_directory/model/data_model.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'saudirectory.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE appsdata (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, data TEXT)",
    );
  }

  Future<DataModel> insert(DataModel dataModel) async {
    var dbClient = await db;

    await dbClient!.insert("appsdata", dataModel.toMap());
    return dataModel;
  }

  Future<void> deleteDB() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'saudirectory.db');

    // Close the database connection before deleting
    await _db?.close();

    // Delete the database
    await deleteDatabase(path);

    // Reopen the database
    _db = await initDatabase();
  }

  Future<Map<String, Object?>> getDataByTitle(String title) async {
    var dbClient = await db;
    final maps = await dbClient
        ?.query('appsdata', where: 'title = ?', whereArgs: [title]);
    return maps![0];
  }

  Future<bool> isAppsDataTableEmpty() async {
    var dbClient = await db;
    final count = Sqflite.firstIntValue(
        (await dbClient?.rawQuery('SELECT COUNT(*) FROM appsdata')) ?? []);
    return count == 0;
  }

  //Searching
  Future<List<Map<String, Object?>>?> getDataColumn() async {
    var dbClient = await db;
    final List<Map<String, Object?>>? maps = await dbClient?.query('appsdata');

    return maps;
  }


}
