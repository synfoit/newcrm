import 'package:flutter/material.dart';
import 'package:newcrm/widget/homedrawer.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              "Home",
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
            elevation: 10,
            backgroundColor: Colors.blue,
            actions: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.more_vert),
              ),
            ],
          ),
          drawer: HomeDrawer(),
          body: Center(
              child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: [
                          const Text('Name:'),
                          SizedBox(width: 100),
                          const Text('Khyati Surve'),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Team Name:'),
                          SizedBox(width: 50),
                          const Text('Java Team'),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('TL'),
                          SizedBox(width: 100),
                          const Text('Khyati Surve'),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('SAM'),
                          SizedBox(width: 100),
                          const Text('Khyati Surve'),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Name'),
                          SizedBox(width: 100),
                          const Text('Khyati Surve'),
                        ],
                      ),
                      Container(),
                    ],
                  ))),
        ));
  }
}
