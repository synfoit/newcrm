
import 'dart:convert';

import 'package:newcrm/Database/LeadDatabase.dart';
import 'package:newcrm/Database/UserDatabase.dart';
import 'package:newcrm/Model/employee.dart';
import 'package:newcrm/Model/lead_api_service.dart';
import 'package:newcrm/config/palette.dart';
import 'package:newcrm/screen/SplashScreen.dart';
import 'package:newcrm/screen/ViewFunnelData.dart';
import 'package:flutter/material.dart';
import 'package:newcrm/screen/bottomNavScreen.dart';
import 'package:newcrm/screen/LeadForm.dart';
import 'package:http/http.dart' as http;
class Custom_Drawer extends StatefulWidget {
  Employee leaduser;
  Custom_Drawer(this.leaduser);
  @override
  State<StatefulWidget> createState() =>_StateCustomerDrawer(leaduser);
}
class _StateCustomerDrawer extends State<Custom_Drawer>{
  Employee leaduser;
  _StateCustomerDrawer(this.leaduser);

  @override
  Widget build(BuildContext context) {
    return ListView(
      // Important: Remove any padding from the ListView.

      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text(leaduser.userName.toString()),
          accountEmail: Text(leaduser.userName.toString()),
          decoration: BoxDecoration(color: Palette.primaryColor),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.orange,
            child: Text(
              leaduser.userName.toString().substring(0,1),
              style: TextStyle(fontSize: 40.0),
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text("Home"),
          onTap: () {
            UserDatabase.instance.getEmployee().then((result){
              //setState(() {
              bottomuser = result;
              print('username bootoom ${bottomuser.userName}');
              // });
            });
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => BottomNavScreen(bottomuser.userName,0)));
          },
        ),
        ListTile(
          leading: Icon(Icons.edit),
          title: Text("LeadForm"),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => LeadForm()));
          },
        ),
        ListTile(
          leading: Icon(Icons.contacts),
          title: Text("View All Funnel"),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ViewFunnelData()));
          },
        ),
        ListTile(
          leading: Icon(Icons.sync),
          title: Text("Sync Lead"),

          onTap: () {
            List<LeadDataSync> leadDataf;
            LeadDatabase.instance.getLeaddata().then((result){
              setState(() {
                leadDataf = result;
                for(int m=0;m<leadDataf.length;m++) {
                  syndata(leadDataf[m]);
                }
              });
            });
          },
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text("Logout"),
          onTap: () {
            UserDatabase.instance.deleteUser(leaduser.userName.toString());
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => SplashPage()));
          },
        ),
      ],
    );
  }
}
Future<String> syndata(LeadDataSync leadDataf) async{
  var url = 'http://172.16.2.124:9090/addLead/';

  final http.Response response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body:jsonEncode(leadDataf.toJson()),
  );
  if (response.statusCode == 200) {

    LeadDatabase.instance.updatestatus('sync', int.parse(response.body));
    return (response.body);
  } else {
    throw Exception('Failed to create album.');
  }
}