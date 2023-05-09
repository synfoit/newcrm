import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CustomerCodeDatabase{
   String path;
  static const _databaseName = "customercodedata.db";
  static const _databaseVersion = 1;
  static const tableName= 'customercode';

  CustomerCodeDatabase._privateConstructor();
  static final CustomerCodeDatabase instance = CustomerCodeDatabase._privateConstructor();
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
      "CREATE TABLE customercode (customercode_id AUTO INCREMENT INTEGER, customer_name TEXT,  customercode TEXT)",
    );
  }

  Future getFileData() async {
    return getDatabasesPath().then((s) {
      return path = s;
    });
  }

  Future insertUser(List<String> user) async {
       Database db = await instance.database;
       var result =  await db.insert(tableName, {'customer_name': user});
    return result;
  }

}