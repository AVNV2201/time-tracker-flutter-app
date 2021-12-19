import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:time_tracker/utils/constants.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    String path = join( await getDatabasesPath(), DBConstants.DB_NAME);
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(DBConstants.CREATE_ACTIVITY_TABLE);
        await db.execute(DBConstants.CREATE_ACTION_TABLE);
      }
    );
  }
}