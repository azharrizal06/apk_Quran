import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Databasemanager {
  Databasemanager._private();
  static Databasemanager instance = Databasemanager._private();
  Database? _db;
  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDB();
    }
    return _db!;
  }

  Future _initDB() async {
    Directory docDir = await getApplicationDocumentsDirectory();
    String path = join(docDir.path, "bookmark");
    return await openDatabase(path, version: 1,
        onCreate: (Database, version) async {
      return await Database.execute('''
CREATE TABLE bookmark (
id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
surah TEXT NOT NULL,
number_surah INTEGER NOT NULL
ayat INTEGER NOT NULL,
juz INTEGER NOT NULL,
via TEXT NOT NULL,
index_ayat TEXT NOT NULL,
last_read INTEGER DEFAULT 0
)

''');
    });
  }

  Future closedb() async {
    _db = await instance._db;
    _db!.close();
  }
}
