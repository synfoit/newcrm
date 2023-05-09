import 'dart:convert';
import 'package:newcrm/Database/UserDatabase.dart';
import 'package:newcrm/Model/employee.dart';
import 'package:newcrm/Model/leaddata.dart';
import 'package:newcrm/screen/WebViewContainer.dart';
import 'package:flutter/material.dart';
import 'package:newcrm/screen/HomeScreen.dart';
import 'package:newcrm/screen/screens.dart';
import 'TargetArchived.dart';
import 'package:http/http.dart' as http;

class BottomNavScreen extends StatefulWidget {

  String userName;
  int currentindex;
  BottomNavScreen(this.userName,this.currentindex);

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState(userName,currentindex);
}
Employee bottomuser;
class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0;
  String userNamedata;
  _BottomNavScreenState(this.userNamedata,this._currentIndex);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserDatabase.instance.getEmployee().then((result){
      setState(() {
        bottomuser = result;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    final List _screens = [
      HomeScreen(),
      StatsScreen(userNamedata),
      TargetArchived(),
      WebViewContainer(),

    ];
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        elevation: 0.0,
        items: [Icons.home, Icons.insert_chart, Icons.event_note, Icons.info]
            .asMap()
            .map((key, value) => MapEntry(
          key,
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 6.0,
                horizontal: 16.0,
              ),
              decoration: BoxDecoration(
                color: _currentIndex == key
                    ? Colors.blue[600]
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Icon(value),
            ),
          ),
        ))
            .values
            .toList(),
      ),
    );
  }


  Future<String> syndata(LeadData leadDataf) async{
    var url = 'http://172.16.2.2:8080/restapi/addLead/';
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
           body:jsonEncode(leadDataf.toJson()),
    );
    if (response.statusCode == 200) {
      return (json.decode(response.body));
    } else {
      throw Exception('Failed to create album.');
    }
  }
}
