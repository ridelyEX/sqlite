import 'dart:io' as io;

import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqlite;
import 'package:path/path.dart';
import 'package:sqlite/db/planetas.dart';

class SqLite {
  static Future<sqlite.Database> db() async {
    //encontrar base de datos
    //String ruta = await sqlite.inMemoryDatabasePath;
    final io.Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    String ruta = join(appDocumentsDir.path, "databases","planetas.db");
    //abrir base de datos
    return sqlite.openDatabase(
      join(ruta, "planetas.db"),
      version: 1,
      singleInstance: true,
      onCreate: (db, version) async {
        await createdb(db);
      },
    );
  }

  static Future<void> createdb(Database db)async {
    const String sql = """
    create table planetas(
    id integer primary key not null autoincrement,
    nombre text not null,
    distSol real not null,
    radio real not null)
    """;
      await db.execute(sql);
  }

  static Future<List<Planetas>> querydb() async {
    // abrir la base de datos
    final Database db = await SqLite.db();
    //realizar la query
    List<Map<String, dynamic>> planets = await db.query("planetas");
    return planets.map((Map<String, dynamic> e){
      return Planetas.deMap(e);
    },).toList();
  }

  static add(List<Planetas> p) {}
}
