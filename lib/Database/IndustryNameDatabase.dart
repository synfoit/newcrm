import 'package:newcrm/Model/IndustryType.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class IndustryNameDatabase{
   String path;
  static const _databaseName = "industrynamedata.db";
  static const _databaseVersion = 1;
  static const tableName = 'industrynametable';

  IndustryNameDatabase._privateConstructor();
  static final IndustryNameDatabase instance = IndustryNameDatabase._privateConstructor();
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
      "CREATE TABLE industrynametable (industryname_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, industryname TEXT)",
    );
  }

  Future getFileData() async {
    return getDatabasesPath().then((s) {
      return path = s;
    });
  }

  Future insertindustrytype(String industryname) async {

    Database db = await instance.database;
    var result = await db.insert(tableName, {'industryname': industryname});

    return result;
  }
  Future<List<IndustryType>> getIndustryType() async {
    Database db = await instance.database;
    var res = await db.rawQuery("select industryname from industrynametable");

    List<IndustryType> industryTypelist =[];
    if (res.isNotEmpty) {
      for (int i=0;i<res.length;i++) {
        industryTypelist.add(IndustryType.fromJson(res[i]));
      }
    }

    return industryTypelist;
  }


}