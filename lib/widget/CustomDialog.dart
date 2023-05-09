import 'dart:async';
import 'dart:convert';

import 'package:newcrm/Database/UserDatabase.dart';
import 'package:newcrm/Model/employee.dart';
import 'package:newcrm/config/ServerIp.dart';
import 'package:newcrm/screen/Screens.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<RoleModel>> _fetchdata;

Future<List<RoleModel>> fetchAlbumRulebasedata(String userName) async {
  String url = ServerIp.serverip + "getUserReportingList/" + userName;
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    List<RoleModel> item = [];
    for (var k in jsonResponse) {
      RoleModel m =
          RoleModel(k["id"], k["user_id"], k["username"], k["report_to"]);
      item.add(m);
    }
    return item;
  } else {
    throw Exception('Unexpected error occured!');
  }
}

Employee CustomDialoguser;
class CustomDialog extends StatefulWidget {
  @override
  _CustomDialogState createState() => _CustomDialogState();
}

List _selecteUserName = [];
class _CustomDialogState extends State<CustomDialog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserDatabase.instance.getEmployee().then((result) {
      setState(() {
        CustomDialoguser = result;
        _fetchdata = fetchAlbumRulebasedata(CustomDialoguser.userName);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sales Person'),
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Expanded(
              child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8.0),
                  children: [
                _buildBody(context),
              ]))
        ]),
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            String UserList = CustomDialoguser.userName;
            for (var s in _selecteUserName) {
              UserList += "," + s;
            }
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BottomNavScreen(UserList,1)));
          },
          child: const Text('OK'),
        ),
      ],
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Sales Person'),
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Expanded(
              child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(8.0),
                  children: [
                _buildBody(context),
              ]))
        ]),
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }

  FutureBuilder<List<RoleModel>> _buildBody(BuildContext context) {
    return FutureBuilder<List<RoleModel>>(
      future: _fetchdata,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<RoleModel> posts = snapshot.data;
          return _rulebaselist(context, posts);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Container _rulebaselist(BuildContext context, List<RoleModel> posts) {
    return Container(
        height: 300.0, // Change as per your requirement
        width: 300.0,
        child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      CheckboxListTile(
                          activeColor: Colors.pink[300],
                          dense: true,
                          //font change
                          title: Text(
                            posts[index].Username,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5),
                          ),
                          value: posts[index].isCheck,
                          onChanged: (bool val) {
                            setState(() {
                              posts[index].isCheck = val;
                              if (val == true) {
                                _selecteUserName.add(posts[index].Username);
                              } else {
                                _selecteUserName.remove(posts[index].Username);
                              }
                            });
                          })
                    ],
                  ),
                ),
              );
            }));
  }
}

class RoleModel {
  int ID;
  int User_id;
  String Username;
  String Report_to;
  bool isCheck = false;

  RoleModel(this.ID, this.User_id, this.Username, this.Report_to);
}
