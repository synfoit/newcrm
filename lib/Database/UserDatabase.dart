import 'package:newcrm/Model/employee.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserDatabase {
   String path;
  static const _databaseName = "mydb.db";
  static const _databaseVersion = 1;
  static const tableName = 'users';

  UserDatabase._privateConstructor();
  static final UserDatabase instance = UserDatabase._privateConstructor();
  // only have a single app-wide reference to the database
  static Database _database;
  Future get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }
  _initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }
  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {

    await db.execute(
      "CREATE TABLE users (userid INTEGER, username TEXT, rule INTEGER, loginstatus TEXT)",
    );
  }

  Future getFileData() async {
    return getDatabasesPath().then((s) {
      return path = s;
    });
  }

  Future insertUser(Employee user) async {
    Database db = await instance.database;
    var result = await db.insert("users", user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
    return result;
  }

  Future<Employee> getEmployee() async {
    Database db = await instance.database;
    var res = await db.rawQuery("select * from users");
    List<Employee> employees = [];
    if (res.isNotEmpty) {
      for (int i = 0; i < res.length; i++) {
        employees.add(Employee.fromMap(res[i]));
      }
    }
    return employees[0];
  }

  Future getUser() async {
    Database db = await instance.database;
    var logins = await db.rawQuery("select * from users");

    if (logins.isEmpty)
      {
      return 0;}

    return logins.length;
  }

  Future getUserData() async {
    Database db = await instance.database;
    var res = await db.rawQuery("select * from users");
    List<Employee> employees = [];
    if (res.isNotEmpty) {
      for (int i = 0; i < res.length; i++) {
        employees.add(Employee.fromMap(res[i]));
      }
    }
    return employees[0];
  }

  Future deleteUser(String username) async {
    Database db = await instance.database;
    var logins =
        db.delete(tableName, where: "username = ?", whereArgs: [username]);
    return logins;
  }
}
