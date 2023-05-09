import 'package:flutter/material.dart';

class MyLeaddataList extends StatefulWidget {
  @override
  MyLeaddataListPageState createState() =>  MyLeaddataListPageState();
}

class MyLeaddataListPageState extends State<MyLeaddataList> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar:  AppBar(
        title:  Text('View FunnelData'),
      ),
      body:  Container(
        padding:  EdgeInsets.all(16.0),

      ),
    );
  }
}