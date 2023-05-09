import 'package:newcrm/Model/lead_api_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;

class LeadDatabase {
   String path;
  static const _databaseName = "leaddata.db";
  static const _databaseVersion = 1;
  static const tableLead = 'lead';

  LeadDatabase._privateConstructor();
  static final LeadDatabase instance = LeadDatabase._privateConstructor();
  static Database _database;

  Future get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {

    await db.execute(
     'CREATE TABLE lead(android_lead_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,lead_id INTEGER,employeename TEXT,customercode TEXT,customername TEXT,visit TEXT,requirement TEXT,projectname TEXT,unit TEXT,customertype TEXT,industrytype TEXT,clss TEXT,meeting TEXT,proposal_status TEXT,submission_status TEXT,sbu TEXT,ssl_value INTEGER,oem_value INTEGER,exp_ord_date TEXT,risk TEXT,ssl_manager TEXT,oem_manager TEXT,di_manager TEXT,remark TEXT,support TEXT,leadcreationDate TEXT,syncwithserver TEXT)'
    );
  }

  Future getFileData() async {
    return getDatabasesPath().then((s) {
      return path = s;
    });
  }

  Future insertLead(int leadId,
  String employeeName,
  String customerCode,
  String customerName,
  String visit,
  String requirement,
  String projectName,
  String unit,
  String customerType,
  String industryType,
  String clss,
  String meeting,
  String proposalStatus,
  String submissionStatus,
  String sBU,
  int sSLValue,
  int oEMValue,
  String expOrdDate,
  String risk,
  String sSLManager,
  String oEMManager,
  String diManager,
  String remark,
  String support,
  String leadCreationDate,
  String syncwithserver) async {
    Database db = await instance.database;
    final data = {
      'lead_id': leadId,
      'employeename': employeeName,
      'customercode': customerCode,
      'customername': customerName,
      'visit': visit,
      'requirement': requirement,
      'projectname': projectName,
      'unit': unit,
      'customertype': customerType,
      'industrytype': industryType,
      'clss': clss,
      'meeting': meeting,
      'proposal_status': proposalStatus,
      'submission_status': submissionStatus,
      'sbu': sBU,
      'ssl_value': sSLValue,
      'oem_value': oEMValue,
      'exp_ord_date': expOrdDate,
      'risk': risk,
      'ssl_manager': sSLManager,
      'oem_manager':oEMManager,
      'di_manager': diManager,
      'remark': remark,
      'support': support,
      'leadcreationDate': leadCreationDate,
      'syncwithserver': syncwithserver};
    var result = await db.insert("lead", data,
        conflictAlgorithm: ConflictAlgorithm.ignore);

    return result;
  }

  Future<List<LeadDataSync>> getLeaddata() async {
    Database db = await instance.database;
    var res = await db.rawQuery("select * from lead WHERE syncwithserver =?",["not_sync"]);
    List<LeadDataSync> employees = [];
    if (res.isNotEmpty) {
      for (var k in res) {
      employees.add(LeadDataSync(int.parse(k['android_lead_id'].toString()),int.parse(k['lead_id'].toString()),k['employeename'].toString(),k['customercode'].toString(),k['customername'].toString(),k['visit'].toString(),k['requirement'].toString(),k['projectname'].toString(),k['unit'].toString(),k['customertype'].toString(),k['industrytype'].toString(),k['clss'].toString(),k['meeting'].toString(),k['proposal_status'].toString(),k['submission_status'].toString(),k['sbu'].toString(),int.parse(k['ssl_value'].toString()),int.parse(k['oem_value'].toString()),k['exp_ord_date'].toString(),k['risk'].toString(),k['ssl_manager'].toString(),k['oem_manager'].toString(),k['di_manager'].toString(),k['remark'].toString(),k['support'].toString(),k['leadcreationDate'].toString(),k['syncwithserver'].toString()));
      }
    }
    return employees;
  }

  Future getLeadCount() async {
    Database db= await instance.database;
    var res= await db.rawQuery("select * from lead WHERE syncwithserver =?",["not_sync"]);

    if(res.isNotEmpty){
      return res.length;
    }
    return 0;
  }
  Future<int> updatestatus(String synStatus,int androidLeadId) async {
    final data = {
    'syncwithserver': synStatus};
    Database db = await instance.database;
    return await db.update(tableLead, data, where: 'android_lead_id = ?', whereArgs: [androidLeadId]);
  }
}
