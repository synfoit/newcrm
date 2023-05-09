import 'package:flutter/material.dart';
import 'package:newcrm/config/palette.dart';
import 'package:newcrm/widget/header.dart';
import 'package:newcrm/widget/inputwrapper.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() {
    return LoginState();
  }
}

class LoginState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [Colors.white, Colors.white, Colors.white]),
        ),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Headers(),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: Palette.primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  )),
              child: InputWrapper(),
            ))
          ],
        ),
      ),
    );
  }
}
