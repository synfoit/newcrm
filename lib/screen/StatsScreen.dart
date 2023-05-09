import 'dart:async';
import 'dart:convert';
import 'package:newcrm/Database/UserDatabase.dart';
import 'package:newcrm/Model/employee.dart';
import 'package:newcrm/config/ServerIp.dart';
import 'package:newcrm/config/palette.dart';
import 'package:newcrm/screen/SalesPipeline.dart';
import 'package:newcrm/widget/CustomDialog.dart';
import 'package:newcrm/widget/StatsGrid.dart';
import 'package:newcrm/widget/customer_drawer.dart';
import 'package:newcrm/widget/syncappbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StatsScreen extends StatefulWidget {
  String userList;
  StatsScreen(this.userList);
  @override
  _StatsScreenState createState() => _StatsScreenState(userList);
}

Employee statsScreenuser;

Future<List<RoleModel>> fetchAlbumRulebasedata(String userName) async {
  String url = ServerIp.serverip + "getUserReportingList/" + userName;
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    List<RoleModel> item = [];
    for (var k in jsonResponse) {
      RoleModel m =RoleModel(k["id"], k["user_id"], k["username"], k["report_to"]);
      item.add(m);
    }
    return item;
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class _StatsScreenState extends State<StatsScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  Future<List<RoleModel>> _fetchdata;
  String users;

  _StatsScreenState(this.users);

  @override
  void initState() {
    super.initState();
    UserDatabase.instance.getEmployee().then((result) {
      setState(() {
        statsScreenuser = result;
        _fetchdata = fetchAlbumRulebasedata(users);
      });
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Palette.primaryColor,
      key: _key,
      // set it here
      appBar: SyncAppbar(_key, "Funnel Overview"),
      drawer: Drawer(
        child: Custom_Drawer(statsScreenuser),
      ),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: <Widget>[
          //_buildHeader(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverToBoxAdapter(
              child: StatsGrid(),
            ),
          ),
          //_buildPopupbtn(),
          SliverPadding(
            padding: const EdgeInsets.only(top: 5.0),
            sliver: SliverToBoxAdapter(
                child: Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(5, 0.0, 0.0, 5.0),
              child: SalesPipeline(statsScreenuser.userName),
            )),
          ),
        ],
      ),
    );
  }

  SliverPadding _buildHeader() {
    return const SliverPadding(
      padding: EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          'Funnel Overview',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  SliverPadding _buildPopupbtn() {
    return SliverPadding(
      padding: const EdgeInsets.all(10.0),
      sliver: SliverToBoxAdapter(
          child: MaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CustomDialog(),
            ),
          );
        },
        child: const Text('Sales person'),
        color: Colors.white,
      )),
    );
  }
}
