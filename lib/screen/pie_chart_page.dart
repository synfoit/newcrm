import 'dart:async';
import 'dart:io';

import 'package:newcrm/Database/UserDatabase.dart';
import 'package:newcrm/Model/employee.dart';
import 'package:newcrm/config/ServerIp.dart';
import 'package:newcrm/data/pie_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:syncfusion_flutter_charts/charts.dart';

List<Data> data = [];
List<String> chartentrydata=[];
Future<List<ChartData>> fetchAlbum(String userName) async {
  await Future<List<ChartData>>.delayed(const Duration(seconds: 2));
  final List<ChartData> chartData = [];
  ChartData chartobject;
  final response = await http.get(Uri.parse(ServerIp.serverip+
      "generateLeadCount/"+ userName));
  stdout.writeln(response);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.


    chartData.add(ChartData("General Count",double.parse(response.body)));
    //return response.body;
  } else {

  }
  //////////////////////////////////////////////////////////////////////////////
  final responseWin = await http.get(Uri.parse(ServerIp.serverip+
      'generateWinLeadCount/'+ userName));
  stdout.writeln(responseWin);
  if (responseWin.statusCode == 200) {

    chartData.add(ChartData("Win Count",double.parse(responseWin.body)));

  } else {

  }
  //////////////////////////////////////////////////////////////////////////////
  final responselive = await http.get(Uri.parse(ServerIp.serverip+
      "generateLiveLeadCount/" + userName));
  stdout.writeln(responselive);
  if (responselive.statusCode == 200) {

    chartData.add(ChartData("Live Count",double.parse(responselive.body)));

  } else {

  }
  //////////////////////////////////////////////////////////////////////////////
  final responseleadcount = await http.get(Uri.parse(ServerIp.serverip+
      "generateLostLeadCount/" + userName));
  stdout.writeln(responseleadcount);
  if (responseleadcount.statusCode == 200) {

    chartData.add( ChartData("Lost Count",double.parse(responseleadcount.body)));
   // return responseleadcount.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
   // throw Exception('Failed to load album');
  }
  //////////////////////////////////////////////////////////////////////////////
  final responseskip = await http.get(Uri.parse(ServerIp.serverip+
      "generateSkipLeadCount/" + userName));
  stdout.writeln(responseskip);
  if (responseskip.statusCode == 200) {

    chartData.add(ChartData("Skip Count",double.parse(responseskip.body)));
   // return responseskip.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
   // throw Exception('Failed to load album');
  }

  return chartData;
}

Future<String> fetchAlbumGenerateLeadCount(String userName) async {
  final response = await http.get(Uri.parse(ServerIp.serverip+
      "generateLeadCount/" + userName));
  stdout.writeln(response);
  if (response.statusCode == 200) {

    ChartData("General Count",double.parse(response.body));
    return response.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<String> fetchAlbumGenerateLiveLeadCount(String userName) async {
  final responselive = await http.get(Uri.parse(ServerIp.serverip+
      "generateLiveLeadCount/" + userName));
  stdout.writeln(responselive);
  if (responselive.statusCode == 200) {

    return responselive.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<String> fetchAlbumGenerateLostLeadCount(String userName) async {
  final responseleadcount = await http.get(Uri.parse(ServerIp.serverip+
      "generateLostLeadCount/" + userName));
  stdout.writeln(responseleadcount);
  if (responseleadcount.statusCode == 200) {

    return responseleadcount.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<String> fetchAlbumGenerateSkipLeadCount(String userName) async {
  final responseskip = await http.get(Uri.parse(ServerIp.serverip+
      "generateSkipLeadCount/" + userName));
  stdout.writeln(responseskip);
  if (responseskip.statusCode == 200) {

    return responseskip.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class PieChartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChartPageState();
}
Employee piechartuser;
class PieChartPageState extends State {
   Future<List<ChartData>> futureAlbum;
   Future<String> fetLeadPipeline;
   Future<String> fetHighrisk;
   Future<String> fetMediumrisk;
   Future<String> fetLowrisk;
   List<ChartData> _chartData;
   //TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();
    _chartData = getChartData();
    //_tooltipBehavior = TooltipBehavior(enable: true);
    UserDatabase.instance.getEmployee().then((result) {
      setState(() {
        piechartuser = result;
        futureAlbum = fetchAlbum(piechartuser.userName);

      });
    });

  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child:_buildBody(context)
       );
  }

  FutureBuilder<List<ChartData>> _buildBody(BuildContext context) {
    return FutureBuilder<List<ChartData>>(
      future: futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<ChartData> posts = snapshot.data;
          return _buildCharts(context, posts);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  _buildCharts(BuildContext context, List<ChartData> posts) {
    return null;
      //SafeArea(
     // child:
      /*SfCircularChart(
        backgroundColor: Colors.white,
        title: ChartTitle(text: 'Sales Pipeline'),
        tooltipBehavior: _tooltipBehavior,
        legend:Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
        series: <CircularSeries>[
          PieSeries<ChartData, String>(
              dataSource: posts,
              xValueMapper: (ChartData data, _) => data.name,
              yValueMapper: (ChartData data, _) => data.percent,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              enableTooltip: true)
        ],
     // ),
      // )
    );*/
  }
  List<ChartData> getChartData() {
    final List<ChartData> chartData = [
      ChartData('General Count', 200),
      ChartData('Win Count', 100),
      ChartData('Lost Count', 300),
      ChartData('Live Count', 800),
      ChartData('Skip Count', 900),
    ];
    return chartData;
  }
}

class ChartData {
  final String name;
  final double percent;
  ChartData(this.name, this.percent);
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'dataname': name,
      'data': percent,
    };
    return map;
  }
    factory ChartData.fromMap(Map data) {
      return ChartData(
      data["dataname"] as String,
      data["data"] as double,
    );}
}
