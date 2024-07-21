
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteHelper {

  static const int version = 1;
  static const String dbName = "contacts";
  static const String tableName = "contact_list";
  static const String columnId = "id";
  static const String columnName = "name";
  static const String columnNumber = "number";
  static const String columnEmail = "email";
  static const String columnGender = "gender";
  static const String columnPassword = "password";

  Future<Database> database() async{
    var path = join(await getDatabasesPath(), dbName);
    return openDatabase(path, version: version, onCreate: (db, version) {
      var query = '''CREATE TABLE $tableName ($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnName TEXT, $columnNumber TEXT, $columnEmail TEXT, $columnGender TEXT, $columnPassword TEXT)''';
      db.execute(query);
    },);
  }

  Future<void> insertData(Map<String, dynamic> value) async {

    var db = await database();
    await db.insert(tableName, value);
  }

  Future<List<Map<String, dynamic>>> fetchData() async{

    var db = await database();
    return db.query(tableName);
  }

  Future<bool> loginAccount(String email, String password) async {
    var db = await database();
    var data = await db.query(tableName, where: '$columnEmail = ? AND $columnPassword = ?', whereArgs: [email, password], limit: 1);

    if (data.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

}