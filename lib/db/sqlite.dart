import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqlite;
import 'package:path/path.dart';

class SqLite {
  static Future<sqlite.Database> db() async {
    //encontrar base de datos
    String ruta = await sqlite.inMemoryDatabasePath;
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
}
