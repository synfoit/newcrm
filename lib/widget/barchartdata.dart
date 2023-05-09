import 'dart:convert';
import 'package:newcrm/Database/UserDatabase.dart';
import 'package:newcrm/Model/employee.dart';
import 'package:flutter/material.dart';
//import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';

List xArray = [];
List yArray = [];
List twoDarray = [];
List gerated_Lead = [];
var generatedLead = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
var generatedLead_new = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

List xArrayWin = [];
List yArrayWin = [];
List twoDarrayWin = [];
var generatedWin = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
var generatedWin_new = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

List xArrayLost = [];
List yArrayLost = [];
List twoDarrayLost = [];
var generatedLost = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
var generatedLost_new = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

List xArrayLive = [];
List yArrayLive = [];
List twoDarrayLive = [];
var generatedLive = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
var generatedLive_new = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

List xArraySkip = [];
List yArraySkip = [];
List twoDarraySkip = [];
var generatedSkip = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
var generatedSkip_new = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
Employee Barchartuser;
class BarchartData extends StatefulWidget {
  String SelectedUserList;
  BarchartData(this.SelectedUserList);
  @override
  State<StatefulWidget> createState() => BarchartDataState();
}

Future<String> fetchAlbum_generate(String UserName) async {

  final response = await http.get(Uri.parse(
      'http://172.16.2.2:8080/restapi/getGeneratedLead/' + "/" + UserName));
  stdout.writeln(response);
  if (response.statusCode == 200) {
    final body = json.decode(response.body) as List;

    xArray = body.map((p) => p[0]).toList();
    yArray = body.map((p) => p[1]).toList();

    for (var i = 0; i < xArray.length; i++) {
      for (var j = 0; j <= 11; j++) {
        if (xArray[i] == j) {
          generatedLead[j] = yArray[i];
        }
      }
    }
    generatedLead_new = generatedLead;
    return response.body;
  } else {
    throw Exception('Failed to load album');
  }
}

Future<String> fetchAlbum_generateWinLead(String UserName) async {

  final response = await http
      .get(Uri.parse("http://172.16.2.2:8080/restapi/getWin" + "/" + UserName));
  if (response.statusCode == 200) {

    // print('Lead gereted count${response.body.toString()}');
    final body = json.decode(response.body) as List;
    // print('Lead gereted body${body}');

    xArrayWin = body.map((p) => p[0]).toList();
    yArrayWin = body.map((p) => p[1]).toList();
    // print('xvalue${xArrayWin}');
    //  print('yvalue${yArrayWin}');

    for (var i = 0; i < xArrayWin.length; i++) {
      //print('print xArray.length ${xArrayWin.length}');
      //  print('print i ${i}');
      for (var j = 0; j <= 11; j++) {
        if (xArrayWin[i] == j) {
          generatedWin[j] = yArrayWin[i];

        }
      }
    }
    generatedWin_new = generatedWin;

    return response.body;
  } else {
    throw Exception('Failed to load album');
  }
}

Future<String> fetchAlbum_generateLiveLead(String UserName) async {
  final responselive = await http.get(
      Uri.parse("http://172.16.2.2:8080/restapi/getLive" + "/" + UserName));
  stdout.writeln(responselive);
  if (responselive.statusCode == 200) {
    final body = json.decode(responselive.body) as List;
    xArrayLive = body.map((p) => p[0]).toList();
    yArrayLive = body.map((p) => p[1]).toList();
    for (var i = 0; i < xArrayLive.length; i++) {
      for (var j = 0; j <= 11; j++) {
        if (xArrayLive[i] == j) {
          generatedLive[j] = yArrayLive[i];
        }
      }
    }
    generatedLive_new = generatedLive;
    return responselive.body;
  } else {
    throw Exception('Failed to load album');
  }
}

Future<String> fetchAlbum_generateLostLead(String UserName) async {

  final responseleadcount = await http.get(
      Uri.parse("http://172.16.2.2:8080/restapi/getLost" + "/" + UserName));
  stdout.writeln(responseleadcount);
  if (responseleadcount.statusCode == 200) {
    final body = json.decode(responseleadcount.body) as List;

    xArrayLost = body.map((p) => p[0]).toList();
    yArrayLost = body.map((p) => p[1]).toList();

    for (var i = 0; i < xArrayLost.length; i++) {
      for (var j = 0; j <= 11; j++) {
        if (xArrayLost[i] == j) {
          generatedLost[j] = yArrayLost[i];
        }
      }
    }
    generatedLost_new = generatedLost;

    return responseleadcount.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<String> fetchAlbum_generateSkipLead(String UserName) async {

  final responseskip = await http.get(
      Uri.parse("http://172.16.2.2:8080/restapi/getSkip" + "/" + UserName));
  stdout.writeln(responseskip);
  if (responseskip.statusCode == 200) {

    final body = json.decode(responseskip.body) as List;

    xArraySkip = body.map((p) => p[0]).toList();
    yArraySkip = body.map((p) => p[1]).toList();

    for (var i = 0; i < xArraySkip.length; i++) {

      for (var j = 0; j <= 11; j++) {

        if (xArraySkip[i] == j) {
          generatedSkip[j] = yArraySkip[i];

        }
      }
    }
    generatedSkip_new = generatedSkip;

    return responseskip.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class BarchartDataState extends State<BarchartData> {
   List<ChartBarData> _chartData;
   //TooltipBehavior _tooltipBehavior;
   Future<String> fet_generate;
   Future<String> fet_win;
   Future<String> fet_live;
   Future<String> fet_lost;
   Future<String> fet_skip;

  @override
  void initState() {
    //_tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
    UserDatabase.instance.getEmployee().then((result){
      setState(() {
        Barchartuser = result;
      });
    });
    _chartData = getChartData();
  }
  @override
  Widget build(BuildContext context) {
    fet_generate = fetchAlbum_generate(Barchartuser.userName);
    fet_win = fetchAlbum_generateWinLead(Barchartuser.userName);
    fet_live = fetchAlbum_generateLiveLead(Barchartuser.userName);
    fet_lost = fetchAlbum_generateLostLead(Barchartuser.userName);
    fet_skip = fetchAlbum_generateSkipLead(Barchartuser.userName);

    return SafeArea(
      //child:
      //Scaffold(
      //body:
     /* SfCartesianChart(
        backgroundColor: Colors.white,
        //  title: ChartTitle(text: 'View Funnel'),
        tooltipBehavior: _tooltipBehavior,
        legend: Legend(isVisible: true),
        primaryXAxis: CategoryAxis(),
        series: <CartesianSeries>[
          ColumnSeries<ChartBarData, String>(
            name: 'Genreted Data',
            dataSource: _chartData,
            xValueMapper: (ChartBarData data, _) => data.month,
            yValueMapper: (ChartBarData data, _) => data.leadgenrete,
          ),
          ColumnSeries<ChartBarData, String>(
            name: 'Win Data',
            dataSource: _chartData,
            xValueMapper: (ChartBarData data, _) => data.month,
            yValueMapper: (ChartBarData data, _) => data.win,
          ),
          ColumnSeries<ChartBarData, String>(
            name: 'Lost Data',
            dataSource: _chartData,
            xValueMapper: (ChartBarData data, _) => data.month,
            yValueMapper: (ChartBarData data, _) => data.live,
          ),
          ColumnSeries<ChartBarData, String>(
            name: 'Skip Data',
            dataSource: _chartData,
            xValueMapper: (ChartBarData data, _) => data.month,
            yValueMapper: (ChartBarData data, _) => data.skip,
          ),
          ColumnSeries<ChartBarData, String>(
            name: 'Live Data',
            dataSource: _chartData,
            xValueMapper: (ChartBarData data, _) => data.month,
            yValueMapper: (ChartBarData data, _) => data.lost,
          )
        ],
      ),*/
    );
  }
  List<ChartBarData> getChartData() {
    print("dataaaaaa${generatedWin_new[8].toDouble()}");
    final List<ChartBarData> chartData = [
      ChartBarData('Jan', 20.0, generatedWin_new[0].toDouble(), 10, 50, 40),
      ChartBarData('Feb', 10.0, generatedWin_new[1].toDouble(), 12, 40, 20),
      ChartBarData('Mar', 30.0, generatedWin_new[2].toDouble(), 13, 20, 10),
      ChartBarData('Apr', 50.0, generatedWin_new[3].toDouble(), 22, 30, 10),
      ChartBarData('May', 40.0, generatedWin_new[4].toDouble(), 45, 20, 40),
      ChartBarData('Jun', 20.0, generatedWin_new[5].toDouble(), 40, 50, 40),
      ChartBarData('Jul', 10.0, generatedWin_new[6].toDouble(), 30, 40, 20),
      ChartBarData('Aug', 30.0, generatedWin_new[7].toDouble(), 32, 20, 10),
      ChartBarData('Sep', 50.0, generatedWin_new[8].toDouble(), 45, 30, 10),
      ChartBarData('Oct', 40.0, generatedWin_new[9].toDouble(), 19, 20, 40),
      ChartBarData('Nov', 10.0, generatedWin_new[10].toDouble(), 36, 40, 20),
      ChartBarData('Dec', 30.0, generatedWin_new[11].toDouble(), 22, 20, 10),
    ];
    return chartData;
  }
}

class ChartBarData {
  final String month;
  final double win;
  final double lost;
  final double live;
  final double skip;
  final double leadgenrete;

  ChartBarData(
      this.month, this.leadgenrete, this.win, this.lost, this.live, this.skip);
}
/*/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    final responsewin = await http.get(
        Uri.parse("http://172.16.2.2:8080/restapi/getWin" + "/" + UserName));
    // if (responsewin.statusCode == 200) {

    // print('Lead gereted count${response.body.toString()}');
    final bodywin = json.decode(responsewin.body) as List;
    // print('Lead gereted body${body}');

    xArrayWin = bodywin.map((p) => p[0]).toList();
    yArrayWin = bodywin.map((p) => p[1]).toList();
    // print('xvalue${xArrayWin}');
    //  print('yvalue${yArrayWin}');

    for (var i = 0; i < xArrayWin.length; i++) {
      //print('print xArray.length ${xArrayWin.length}');
      //  print('print i ${i}');
      for (var j = 0; j <= 11; j++) {
        if (xArrayWin[i] == j) {
          generatedWin[j] = yArrayWin[i];
          print('print generatedLeaddata...... ${generatedWin[j]}');
        }
      }
    }
    generatedWin_new = generatedWin;
    print('Lead gereted win array////${generatedWin_new[8].toDouble()}');

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    final responselive = await http.get(
        Uri.parse("http://172.16.2.2:8080/restapi/getLive" + "/" + UserName));
    stdout.writeln(responselive);
    // if (responselive.statusCode == 200) {
    final bodyLive = json.decode(responselive.body) as List;
    xArrayLive = bodyLive.map((p) => p[0]).toList();
    yArrayLive = bodyLive.map((p) => p[1]).toList();
    for (var i = 0; i < xArrayLive.length; i++) {
      for (var j = 0; j <= 11; j++) {
        if (xArrayLive[i] == j) {
          generatedLive[j] = yArrayLive[i];
        }
      }
    }
    generatedLive_new = generatedLive;

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    final responseleadlost = await http.get(
        Uri.parse("http://172.16.2.2:8080/restapi/getLost" + "/" + UserName));
    stdout.writeln(responseleadlost);
    // if (responseleadcount.statusCode == 200) {
    final bodylost = json.decode(responseleadlost.body) as List;

    xArrayLost = bodylost.map((p) => p[0]).toList();
    yArrayLost = bodylost.map((p) => p[1]).toList();

    for (var i = 0; i < xArrayLost.length; i++) {
      for (var j = 0; j <= 11; j++) {
        if (xArrayLost[i] == j) {
          generatedLost[j] = yArrayLost[i];
        }
      }
    }
    generatedLost_new = generatedLost;

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    final responseskip = await http.get(
        Uri.parse("http://172.16.2.2:8080/restapi/getSkip" + "/" + UserName));
    stdout.writeln(responseskip);
    //  if (responseskip.statusCode == 200) {

    final bodyskip = json.decode(responseskip.body) as List;

    xArraySkip = bodyskip.map((p) => p[0]).toList();
    yArraySkip = bodyskip.map((p) => p[1]).toList();

    for (var i = 0; i < xArraySkip.length; i++) {
      for (var j = 0; j <= 11; j++) {
        if (xArraySkip[i] == j) {
          generatedSkip[j] = yArraySkip[i];
        }
      }
    }
    generatedSkip_new = generatedSkip;*/