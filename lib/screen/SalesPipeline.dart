import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:newcrm/Database/UserDatabase.dart';
import 'package:newcrm/Model/employee.dart';
import 'package:newcrm/config/ServerIp.dart';
import 'package:newcrm/config/palette.dart';
import 'package:newcrm/widget/CustomDialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:syncfusion_flutter_charts/charts.dart';

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

 Future<String> fet_generate;
 Future<String> fet_win;
 Future<String> fet_live;
 Future<String> fet_lost;
 Future<String> fet_skip;
List<ChartBarData> chartData = [];

 //TooltipBehavior _tooltipBehavior;
 Future<List<ChartBarData>> _getdatabar;
 Future<String> _getlowsaledata,_getHighSaleData,_getMediumSaleData;


var monthList = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jan',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

Employee salesuser;

class SalesPipeline extends StatefulWidget {
  String UserList;

  SalesPipeline(this.UserList);

  @override
  State<StatefulWidget> createState() => SalesPipelineState(UserList);
}

Future<List<ChartBarData>> fetchAlbumGenerate(String userName) async {
  await Future<List<ChartBarData>>.delayed(const Duration(seconds: 2));

  final response = await http
      .get(Uri.parse(ServerIp.serverip + 'getGeneratedLead/' + userName));
  stdout.writeln(response);
  if (response.statusCode == 200) {
    final body = json.decode(response.body) as List;
    xArray = body.map((p) => p[0]).toList();
    yArray = body.map((p) => p[1]).toList();
    for (var i = 0; i < xArray.length; i++) {
      for (var j = 1; j <= 12; j++) {
        if (xArray[i] == j) {
          generatedLead[j - 1] = yArray[i];
        }
      }
    }
    generatedLead_new = generatedLead;
  } else {}
////////////////////////////////////////////////////////////////////////////////

  final responsewin =
      await http.get(Uri.parse(ServerIp.serverip + "getWin/" + userName));
  if (responsewin.statusCode == 200) {
    final bodywin = json.decode(responsewin.body) as List;
    xArrayWin = bodywin.map((p) => p[0]).toList();
    yArrayWin = bodywin.map((p) => p[1]).toList();
    for (var i = 0; i < xArrayWin.length; i++) {
      for (var j = 1; j <= 12; j++) {
        if (xArrayWin[i] == j) {
          generatedWin[j - 1] = yArrayWin[i];
        } else {}
      }
      generatedWin_new = generatedWin;
    }
  } else {}
  ////////////////////////////////////////////////////////////////////////
  final responselive =
      await http.get(Uri.parse(ServerIp.serverip + "getLive/" + userName));
  stdout.writeln(responselive);
  if (responselive.statusCode == 200) {
    final body = json.decode(responselive.body) as List;
    xArrayLive = body.map((p) => p[0]).toList();
    yArrayLive = body.map((p) => p[1]).toList();
    for (var i = 0; i < xArrayLive.length; i++) {
      for (var j = 1; j <= 12; j++) {
        if (xArrayLive[i] == j) {
          generatedLive[j - 1] = yArrayLive[i];
        }
      }
    }
    generatedLive_new = generatedLive;
  } else {}
  //////////////////////////////////////////////////////////////////////////////

  final responseleadcount =
      await http.get(Uri.parse(ServerIp.serverip + "getLost/" + userName));
  stdout.writeln(responseleadcount);
  if (responseleadcount.statusCode == 200) {
    final body = json.decode(responseleadcount.body) as List;
    xArrayLost = body.map((p) => p[0]).toList();
    yArrayLost = body.map((p) => p[1]).toList();
    for (var i = 0; i < xArrayLost.length; i++) {
      for (var j = 1; j <= 12; j++) {
        if (xArrayLost[i] == j) {
          generatedLost[j - 1] = yArrayLost[i];
        }
      }
    }
    generatedLost_new = generatedLost;
  } else {}

  //////////////////////////////////////////////////////////////////

  final responseskip =
      await http.get(Uri.parse(ServerIp.serverip + "getSkip/" + userName));
  stdout.writeln(responseskip);
  if (responseskip.statusCode == 200) {
    final body = json.decode(responseskip.body) as List;
    xArraySkip = body.map((p) => p[0]).toList();
    yArraySkip = body.map((p) => p[1]).toList();
    for (var i = 0; i < xArraySkip.length; i++) {
      for (var j = 1; j <= 12; j++) {
        if (xArraySkip[i] == j) {
          generatedSkip[j - 1] = yArraySkip[i];
        }
      }
    }
    generatedSkip_new = generatedSkip;
  } else {}

  ///////////////////////////////////////////////////////////////

  final List<ChartBarData> chartData = [];
  //ChartBarData chartBarData;
  for (int p = 0; p <= 11; p++) {
    ChartBarData chartBarData = ChartBarData(
        monthList[p],
        generatedLead_new[p].toDouble(),
        generatedWin_new[p].toDouble(),
        generatedLost_new[p].toDouble(),
        generatedLive_new[p].toDouble(),
        generatedSkip_new[p].toDouble());
    chartData.add(chartBarData);
  }

  return chartData;
}

Future<String> getLowsaleData(String userName) async{
  await Future<List<ChartBarData>>.delayed(const Duration(seconds: 2));

  final response = await http
      .get(Uri.parse(ServerIp.serverip + 'getLowSalesOverview/' + userName));
  stdout.writeln(response);
  if (response.statusCode == 200) {

    return response.body.replaceAll("[", "").replaceAll("]", "");
  } else {
    return "";
  }
}
Future<String> getHighsaleData(String userName) async{
  await Future<List<ChartBarData>>.delayed(const Duration(seconds: 2));
  final response = await http
      .get(Uri.parse(ServerIp.serverip + 'getHighSalesOverview/' + userName));
  stdout.writeln(response);
  if (response.statusCode == 200) {
    return response.body.replaceAll("[", "").replaceAll("]", "");
  } else {
    return "";
  }
}
Future<String> getMediumaleData(String userName) async{
  await Future<List<ChartBarData>>.delayed(const Duration(seconds: 2));
  final response = await http
      .get(Uri.parse(ServerIp.serverip + 'getMediumSalesOverview/' + userName));
  stdout.writeln(response);
  if (response.statusCode == 200) {
    return response.body.replaceAll("[", "").replaceAll("]", "");
  } else {
    return "";
  }
}


class SalesPipelineState extends State<SalesPipeline> {
  String userList;

  SalesPipelineState(this.userList);

  @override
  void initState() {
    UserDatabase.instance.getEmployee().then((result) {
      setState(() {
        salesuser = result;
        _getdatabar = fetchAlbumGenerate(userList);
        _getlowsaledata=getLowsaleData(userList);
        _getHighSaleData=getHighsaleData(userList);
        _getMediumSaleData=getMediumaleData(userList);
      });
    });

    //_tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  get borderRadius => BorderRadius.circular(8.0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget> [
          InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: borderRadius, color: Colors.white),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Sales Overview',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.all(5),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CustomDialog(),
                            ),
                          );
                        },
                        label: Text('Sales Person'),
                        icon: Icon(Icons.arrow_drop_down),
                        style: ElevatedButton.styleFrom(
                          primary: Palette.primaryColor,
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
          SizedBox(height: 30,),
          _buildBody(context),
          SizedBox(height: 30,),
          _buildLowSalesOverview("Low"),
          _buildMediumSalesOverview("Medium"),
          _buildHighSalesOverview("High"),


        ],
      ),
    );
  }
}

FutureBuilder<List<ChartBarData>> _buildBody(BuildContext context) {
  return FutureBuilder<List<ChartBarData>>(
    future: _getdatabar,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        final List<ChartBarData> posts = snapshot.data;
       // return _buildCharts(context, posts);
        return null;
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}

/*_buildCharts(BuildContext context, List<ChartBarData> posts) {
  return SfCartesianChart(
    backgroundColor: Colors.white,
    tooltipBehavior: _tooltipBehavior,
    legend: Legend(isVisible: true),
    primaryXAxis: CategoryAxis(),
    series: <CartesianSeries>[
      ColumnSeries<ChartBarData, String>(
        name: 'Genreted Data',
        dataSource: posts,
        xValueMapper: (ChartBarData data, _) => data.month,
        yValueMapper: (ChartBarData data, _) => data.leadgenrete,

      ),
      ColumnSeries<ChartBarData, String>(
        name: 'Win Data',
        dataSource: posts,
        xValueMapper: (ChartBarData data, _) => data.month,
        yValueMapper: (ChartBarData data, _) => data.win,
      ),
      ColumnSeries<ChartBarData, String>(
        name: 'Lost Data',
        dataSource: posts,
        xValueMapper: (ChartBarData data, _) => data.month,
        yValueMapper: (ChartBarData data, _) => data.live,
      ),
      ColumnSeries<ChartBarData, String>(
        name: 'Skip Data',
        dataSource: posts,
        xValueMapper: (ChartBarData data, _) => data.month,
        yValueMapper: (ChartBarData data, _) => data.skip,
      ),
      ColumnSeries<ChartBarData, String>(
        name: 'Live Data',
        dataSource: posts,
        xValueMapper: (ChartBarData data, _) => data.month,
        yValueMapper: (ChartBarData data, _) => data.lost,
      )
    ],
    // ),
  );
}*/

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

Container _buildLowSalesOverview(String title) {
  return
    //Expanded(   child:
      Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          FutureBuilder<String>(
            future: _getlowsaledata,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  snapshot.data,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    //),
  );
}
Container _buildHighSalesOverview(String title) {
  return
    //Expanded(child:
    Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          FutureBuilder<String>(
            future: _getHighSaleData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  snapshot.data,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    //),
  );
}
Container _buildMediumSalesOverview(String title) {
  return
    //Expanded(child:
    Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          FutureBuilder<String>(
            future: _getMediumSaleData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  snapshot.data,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    //),
  );
}