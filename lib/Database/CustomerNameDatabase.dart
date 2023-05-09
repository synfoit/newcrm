import 'package:newcrm/Model/CodeCustomer.dart';
import 'package:newcrm/Model/CustomerCode.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CustomerNameDatabase{
   String path;
  static const _databaseName = "customernamedata.db";
  static const _databaseVersion = 1;
  static const tableName = 'customernametable';

  CustomerNameDatabase._privateConstructor();
  static final CustomerNameDatabase instance = CustomerNameDatabase._privateConstructor();
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
      "CREATE TABLE customernametable (customerid INTEGER,  customername TEXT, customercode TEXT,report_to TEXT)",
    );
  }

  Future getFileData() async {
    return getDatabasesPath().then((s) {
      return path = s;
    });
  }

  Future insertCustomerData(CodeCustomer user) async {
    Database db = await instance.database;
    var result;
    result= await db.insert(tableName, user.toJson(),
          conflictAlgorithm: ConflictAlgorithm.ignore);
    return result;
  }

  Future<List<String>> getCustomerName() async {
    Database db = await instance.database;
    var res = await db.rawQuery("select customername from customernametable");
    List<CustomerCode> customerNameList=[];
    if (res.isNotEmpty) {
      for (int i = 0; i < res.length; i++) {
        customerNameList.add(CustomerCode.fromJson(res[i]));
      }
    }


    List<String> datalist=[];
    for(int k=0;k<customerNameList.length;k++)
      {
        datalist.add(customerNameList[k].customername);
      }
    return datalist;
  }


  Future<String> getCustomerCode(String customerName) async {
    Database db = await instance.database;
    var res = await db.rawQuery("SELECT customercode FROM customernametable WHERE customername =?", [customerName]);
    String customerCode;
    customerCode=res.first['customercode'].toString();
    return customerCode;
  }

}