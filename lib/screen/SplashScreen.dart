import 'dart:async';
import 'package:newcrm/Database/UserDatabase.dart';
import 'package:newcrm/Model/employee.dart';
import 'package:newcrm/screen/loginpage.dart';
import 'package:flutter/material.dart';
import 'bottomNavScreen.dart';

class SplashPage extends StatefulWidget {
  @override
  State createState() {
    return SplashState();
  }
}

class SplashState extends State {
  int login = 101;
  int loginData;
  Employee bottomuser;
  @override
  void initState() {
    super.initState();
    loginData = login;
    UserDatabase.instance.getEmployee().then((result){
      setState(() {
        bottomuser = result;
      });
    });
     Future.delayed(const Duration(seconds: 1), () {
      UserDatabase.instance.getUser().then((result) {
        setState(() {
          print("result${result}");
          loginData = result;
          if (loginData == 0)
            {
            Timer(
                Duration(seconds: 3),
                () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage())));}
          else {
            Timer(Duration(seconds: 3), () =>
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) =>
                        BottomNavScreen(bottomuser.userName,0))));
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var assetsImage =  AssetImage(
        'asset/images/crm.png'); //<- Creates an object that fetches an image.
    var image =  Image(
        image: assetsImage,
        height:300);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(
          decoration:  BoxDecoration(color: Colors.white),
          child:  Center(
            child: image,
          ),
        ));
  }

}
