import 'package:newcrm/Model/employee.dart';
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;

class DBHelper {

  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

 initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'userdata.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db
        .execute('CREATE TABLE userinfo (userid INTEGER, username TEXT, rule INTEGER, loginstatus TEXT)');
  }
  Future getUser() async{
    Database db = await instance._db;
    var logins=await  db.rawQuery("select * from userinfo");
    if(logins.isNotEmpty)
      {
      return 0;}
    return logins.length;

  }
  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      'userdata',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> getcount() async
  {
    var dbClient = await db;
    List<Map> maps = await dbClient.query('userinfo', columns: ['userid', 'username','rule','loginstatus']);
    return maps.length;
  }

  Future<int> update(Employee employee) async {
    var dbClient = await db;
    return await dbClient.update(
      'userinfo',
      employee.toMap(),
      where: 'id = ?',
      whereArgs: [employee.userid],
    );
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}