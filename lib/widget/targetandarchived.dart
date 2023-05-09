import 'dart:async';
import 'dart:io';

import 'package:newcrm/data/pie_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:syncfusion_flutter_charts/charts.dart';

List<Data> data = [];

Future<String> fetchAlbum(String UserName) async {
  final response = await http.get(Uri.parse(
      'http://172.16.2.2:8080/restapi/generateWinLeadCount/'+ UserName));
  stdout.writeln(response);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    return response.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<String> fetchAlbum_generateLeadCount(String UserName) async {
  final response = await http.get(Uri.parse(
      "http://172.16.2.2:8080/restapi/generateLeadCount/" + UserName));
  stdout.writeln(response);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.


    return response.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<String> fetchAlbum_generateLiveLeadCount(String UserName) async {
  final responselive = await http.get(Uri.parse(
      "http://172.16.2.2:8080/restapi/generateLiveLeadCount/"  + UserName));
  stdout.writeln(responselive);
  if (responselive.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.


    return responselive.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<String> fetchAlbum_generateLostLeadCount(String UserName) async {
  final responseleadcount = await http.get(Uri.parse(
      "http://172.16.2.2:8080/restapi/generateLostLeadCount/" + UserName));
  stdout.writeln(responseleadcount);
  if (responseleadcount.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.


    return responseleadcount.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<String> fetchAlbum_generateSkipLeadCount(String UserName) async {
  final responseskip = await http.get(Uri.parse(
      "http://172.16.2.2:8080/restapi/generateSkipLeadCount/" + UserName));
  stdout.writeln(responseskip);
  if (responseskip.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.


    return responseskip.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class TargetChartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TargetChartPageState();
}

class TargetChartPageState extends State {
   Future<String> futureAlbum;
   Future<String> fet_lead_pipeline;
   Future<String> fet_highrisk;
   Future<String> fet_mediumrisk;
   Future<String> fet_lowrisk;
   List<ChartData> _chartData;
  // TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    //_tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    futureAlbum = fetchAlbum('Ankit Chaurasia');
    fet_lead_pipeline = fetchAlbum_generateLeadCount('Ankit Chaurasia');
    fet_highrisk = fetchAlbum_generateLiveLeadCount('Ankit Chaurasia');
    fet_mediumrisk = fetchAlbum_generateLostLeadCount('Ankit Chaurasia');
    fet_lowrisk = fetchAlbum_generateSkipLeadCount('Ankit Chaurasia');

    return SafeArea(
      //child:
      // Scaffold(
      //body:
     /* SfCircularChart(
        backgroundColor: Colors.white,
        title: ChartTitle(text: 'Tareget & Achived '),
        tooltipBehavior: _tooltipBehavior,
        legend:
        Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
        series: <CircularSeries>[
      RadialBarSeries<ChartData, String>(
              dataSource: _chartData,
              xValueMapper: (ChartData data, _) => data.name,
              yValueMapper: (ChartData data, _) => data.percent,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true,
              maximumValue: 300)
        ],
      ),*/
      // )
    );
  }

  List<ChartData> getChartData() {
    final List<ChartData> chartData = [
      ChartData('Target', 200),
      ChartData('Archived', 100),

    ];
    return chartData;
  }
}

class ChartData {
  final String name;
  final double percent;
  ChartData(this.name, this.percent);
}
