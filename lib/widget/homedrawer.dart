import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 50, left: 8, right: 8, bottom: 8),
            // color: HexColor("#31343E"),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Image.asset(
                    "assets/avatar.png",
                    width: 80,
                    height: 80,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Name Surname\n",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            color: Colors.black87)),
                    TextSpan(
                        text: "@username",
                        style: TextStyle(
                            fontFamily: 'Montserrat', color: Colors.black54)),
                  ]),
                ),
              ],
            ),
          ),
          Divider(height: 1, thickness: 1, color: Colors.blueGrey[900]),
          Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                ListTile(
                  dense: true,
                  title: Text(
                    "Home",
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: Icon(Icons.home),
                  onTap: () {
                    Navigator.pushNamed(context, "/home");
                  },
                ),
                ListTile(
                  dense: true,
                  title: Text(
                    "Lead Form",
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: Icon(Icons.list),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    "Edit Lead",
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: Icon(Icons.edit),
                  onTap: () {
                    Navigator.pushNamed(context, "/notifications");
                  },
                ),
              ],
            ),
          ),
        ]));
  }
}
