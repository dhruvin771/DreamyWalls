import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Database? _db;

  initDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "image.db");
    var db = await openDatabase(path, version: 1, onCreate: onCreate);
    return db;
  }

  void onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE FavouriteImage(image TEXT)');
  }

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDB();
      return _db;
    } else {
      return _db;
    }
  }

  Future<int> addImage(String image) async {
    var dbReady = await db;
    return await dbReady!
        .rawInsert("INSERT INTO FavouriteImage(image) VALUES('${image}')");
  }

  Future<int?> deleteImage(String image) async {
    var dbReady = await db;
    return await dbReady
        ?.rawDelete("DELETE FROM FavouriteImage WHERE image = ?", [image]);
  }

  Future<bool> isImageAvailable(String image) async {
    var dbReady = await db;
    var result = await dbReady!.rawQuery(
        "SELECT COUNT(*) AS count FROM FavouriteImage WHERE image = ?",
        [image]);
    if (result.isNotEmpty) {
      var count = result[0]['count'];
      if (count != null && count is int) {
        return count > 0;
      }
    }
    return false;
  }

  Future<List<String>> getAllImages() async {
    var dbReady = await db;
    var result = await dbReady!.query('FavouriteImage');
    return result.map((e) => e['image'] as String).toList();
  }
}
