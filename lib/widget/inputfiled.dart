import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: TextField(
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
          child: TextField(
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
    );
  }
}
