import 'package:newcrm/Database/CustomerNameDatabase.dart';
import 'package:newcrm/Database/CustomerTypeDatabase.dart';
import 'package:newcrm/Database/IndustryNameDatabase.dart';
import 'package:newcrm/Database/UserDatabase.dart';
import 'package:newcrm/Model/CodeCustomer.dart';
import 'package:newcrm/Model/employee.dart';
import 'package:newcrm/config/ServerIp.dart';
import 'package:newcrm/screen/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:newcrm/config/palette.dart';
import 'package:newcrm/screen/bottomNavScreen.dart';
import 'package:newcrm/widget/Button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class InputWrapper extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
   Future<String> getdata;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(50),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Container(
            decoration: BoxDecoration(
                color: Palette.primaryColor,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'asset/images/icons_person24.png',
                          width: 20,
                          height: 20,
                          fit: BoxFit.fill,
                        ),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(),
                      labelText: 'Enter User Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'asset/images/icons_lock24.png',
                          width: 20,
                          height: 20,
                          fit: BoxFit.fill,
                        ),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(),
                      labelText: 'Enter Password',
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: () {
              fetchAlbum_Logindata(nameController.text, passwordController.text)
                  .then((value) {
                if (value == 1) {
                  fetchAlbum_getCustomerName();
                  fetchAlbum_getCustomerType();
                  fetchAlbum_getIndustryType();
                  UserDatabase.instance.getEmployee().then((result){
                    //setState(() {
                    bottomuser = result;
                    // });
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BottomNavScreen(bottomuser.userName,0)),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                }
              });
            },
            child: Button(),
          )
        ],
      ),
    );
  }
}
getValue() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('key');
  return stringValue;
}
saveValue(String Username) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('key', Username);
}
Future<dynamic> fetchAlbum_Logindata(String Userid, String password) async {
  final response = await http.get(Uri.parse(ServerIp.serverip+
      "getUserId/" + Userid + "/" + password));
  stdout.writeln(response);
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    for (var k in jsonResponse) {
      if (k["loginstatus"] == "successful") {
        var result = UserDatabase.instance.insertUser(
            Employee(k["userid"], k["userName"], k["rule"], k["loginstatus"]));
        return result;
      } else {
        return '-1';
      }
    }
    return '0';
  } else {
    throw Exception('Failed to load album');
  }
}
Future<List<String>> fetchAlbum_getCustomerName() async {
  List<String> CustomerName = [];
  final responsecustomer =
  await http.get(Uri.parse(ServerIp.serverip+"getCustomerNameList"));
  if (responsecustomer.statusCode == 200) {
    var CustomerNamelist = json.decode(responsecustomer.body);
    for (var k in CustomerNamelist) {
      CodeCustomer.fromJson(k);
      CustomerNameDatabase.instance.insertCustomerData(CodeCustomer(k['customerid'],k['customername'],k['customercode'],k['report_to']));
    }
    return CustomerName;
  } else {
    throw Exception('Failed to load album');
  }
}
Future<List<String>> fetchAlbum_getCustomerType() async {
  List<String> CustomerType = [];
  final responseCustomerType =
  await http.get(Uri.parse(ServerIp.serverip+"getCustomerType"));
  if (responseCustomerType.statusCode == 200) {
    var CustomerNametype = json.decode(responseCustomerType.body);
    for (var k in CustomerNametype) {
      CustomerType.add(k);
      CustomerTypeDatabase.instance.insertcustomertype(k);
    }
    return CustomerType;
  } else {
    throw Exception('Failed to load album');
  }
}
Future<List<String>> fetchAlbum_getIndustryType() async {
  List<String> IndustyType = [];
  final responseIndustrytype =
  await http.get(Uri.parse(ServerIp.serverip+"getIndustryType"));
  if (responseIndustrytype.statusCode == 200) {
    var Industrytype = json.decode(responseIndustrytype.body);
    for (var k in Industrytype) {
      IndustyType.add(k);
      IndustryNameDatabase.instance.insertindustrytype(k);
    }
    return IndustyType;
  } else {
    throw Exception('Failed to load album');
  }
}
