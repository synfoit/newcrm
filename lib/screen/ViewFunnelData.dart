import 'package:newcrm/Database/UserDatabase.dart';
import 'package:newcrm/Model/RulebaseData.dart';
import 'package:newcrm/Model/employee.dart';
import 'package:newcrm/Model/leaddata.dart';
import 'package:newcrm/config/ServerIp.dart';
import 'package:newcrm/widget/customer_drawer.dart';
import 'package:newcrm/widget/syncappbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<LeadData> itemdat = [];
String datashow = "";
Employee viewfunneluser;

Future<List<LeadData>> fetchDataReporting(String username) async {
  String url =ServerIp.serverip+
      "getUserReportingList/" + username;
  String userList = username;
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    List<RulebaseData> item = [];
    for (var k in jsonResponse) {
      userList += "," + k["username"];
      RulebaseData m =
          RulebaseData(k["id"], k["user_id"], k["username"], k["report_to"]);
      item.add(m);
    }
  } else {
    throw Exception('Unexpected error occured!');
  }

  String urlfunnel =ServerIp.serverip+
      "getFunnelData/"+ userList;

  final responseleaddata = await http.get(Uri.parse(urlfunnel));
  if (responseleaddata.statusCode == 200) {
    final List<dynamic> jsonResponsedata = json.decode(responseleaddata.body);

    var value = jsonResponsedata
        .map((dynamic i) => LeadData.fromJson(i as Map<String, dynamic>))
        .toList();

    return Future.value(value);
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class ViewFunnelData extends StatefulWidget {
  @override
  _ViewFunnelDataList createState() => _ViewFunnelDataList();
}

class _ViewFunnelDataList extends State<ViewFunnelData> {
  Future<List<LeadData>> reportTodata;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    UserDatabase.instance.getEmployee().then((result) {
      setState(() {
        viewfunneluser = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        appBar: SyncAppbar(_key, "Update Funnel"),
        drawer: Drawer(
          child: Custom_Drawer(viewfunneluser),
        ),
        body: _buildBody(context, viewfunneluser.userName));
  }

  FutureBuilder<List<LeadData>> _buildBody(
      BuildContext context, String userName) {
    return FutureBuilder<List<LeadData>>(
      future: fetchDataReporting(userName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<LeadData> posts = snapshot.data;
          return _buildPosts(context, posts);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView _buildPosts(BuildContext context, List<LeadData> posts) {
    return ListView.builder(
      itemCount: posts.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
            child: ExpansionTile(
                title: Text(posts[index].Lead_Id.toString() +
                    "    " +
                    posts[index].ProjectName),
                subtitle: Text('EO Date : ${posts[index].Exp_Ord_Date}' +
                    '            ' +
                    'SSL Value: ${posts[index].SSLValue.toString()}'),
                children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(children: <Widget>[
                      Column(children: <Widget>[
                        setRiskicon(posts[index].Risk),
                        Container(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              posts[index].Risk,
                              style: const TextStyle(fontSize: 18),
                            )),
                      ]),
                      const SizedBox(width: 80),
                      Column(children: <Widget>[
                        setLiveIcon(posts[index].ProposalStatus),
                        Container(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            posts[index].ProposalStatus,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ]),
                      const SizedBox(width: 80),
                      Column(children: <Widget>[
                        setSubmittedIcon(posts[index].SubmissionStatus),
                        Container(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              posts[index].SubmissionStatus,
                              style: const TextStyle(fontSize: 18),
                            )),
                      ]),
                    ]),
                    Container(
                      padding: const EdgeInsets.all(4.0),
                      width: 300.0,
                      child: Text(
                        posts[index].Remark,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4.0),
                      width: 300.0,
                      child: Text(
                        posts[index].Support,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.all(4.0),
                        width: 100.0,
                        child: ElevatedButton(
                            child: const Text("Update"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      _buildPopupDialog(context, posts[index]),
                                ),
                              );
                            })),
                  ])
            ]));
      },
    );
  }
}

setRiskicon(String risk) {
  if (risk == 'LOW') {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Image.asset(
        'asset/images/icons_low_risk.png',
        width: 20,
        height: 20,
        fit: BoxFit.fill,
      ),
    );
  } else if (risk == 'High') {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Image.asset(
        'asset/images/icons_high_risk.png',
        width: 20,
        height: 20,
        fit: BoxFit.fill,
      ),
    );
  } else {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Image.asset(
        'asset/images/icons_medium_risk.png',
        width: 20,
        height: 20,
        fit: BoxFit.fill,
      ),
    );
  }
}

setLiveIcon(String live) {
  if (live == 'LIVE') {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Image.asset(
        'asset/images/icons_green_live.png',
        width: 20,
        height: 20,
        fit: BoxFit.fill,
      ),
    );
  } else {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Image.asset(
        'asset/images/icons_black_live.png',
        width: 20,
        height: 20,
        fit: BoxFit.fill,
      ),
    );
  }
}

setSubmittedIcon(String submitted) {
  if (submitted == 'SUBMITTED') {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Image.asset(
        'asset/images/icons_ok.png',
        width: 20,
        height: 20,
        fit: BoxFit.fill,
      ),
    );
  } else {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Image.asset(
        'asset/images/icons_green_live.png',
        width: 20,
        height: 20,
        fit: BoxFit.fill,
      ),
    );
  }
}

TextEditingController _projectName = TextEditingController();

TextEditingController _risktype = TextEditingController();
TextEditingController _ordervalueSsl = TextEditingController();

TextEditingController _expectedDate = TextEditingController();
TextEditingController _submissionStatus = TextEditingController();
TextEditingController _support = TextEditingController();
TextEditingController _remark = TextEditingController();
TextEditingController _propasolstatus = TextEditingController();

Widget _buildPopupDialog(BuildContext context, LeadData post) {


  return  AlertDialog(
    title: const Text('Popup example'),
    content: SingleChildScrollView(
        // mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.start,
        child: Form(
            child: Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: _projectName,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: post.ProjectName,
              hintText: 'Update Project Name',
            ),
            //onSaved: (val) => this.project != val,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: _expectedDate,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: post.Exp_Ord_Date,
              hintText: 'Update Expected Order value',
            ),
            // onSaved: (val) => this.project != val,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: _ordervalueSsl,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: post.SSLValue.toString(),
              hintText: 'Update SSL Value',
            ),
            //onSaved: (val) => this.project != val,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: _risktype,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: post.Risk,
              hintText: 'Update Risk',
            ),
            //onSaved: (val) => this.project != val,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: _propasolstatus,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: post.ProposalStatus,
              hintText: 'Update Proposal Status',
            ),
            //onSaved: (val) => this.project != val,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: _submissionStatus,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: post.SubmissionStatus,
              hintText: 'Update Proposal Submission Status',
            ),
            //   onSaved: (val) => this.project != val,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: _remark,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: post.Remark,
              hintText: 'Update Remark',
            ),
            //onSaved: (val) => this.project != val,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: _support,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: post.Support,
              hintText: 'Update Support',
            ),
            //onSaved: (val) => this.project != val,
          ),
        ),
      ],
    ))),
    actions: <Widget>[
       TextButton(
        onPressed: () {
          String projectName,expectedDate,rskType,propasolStatus,remark,support,submissionStatus;
          String ordervalueSsl;
          if(_projectName.text.isEmpty)
            {
              projectName=post.ProjectName;
            }
          else{
            projectName=_projectName.text;
          }
          if(_expectedDate.text.isEmpty){
            expectedDate=post.Exp_Ord_Date;
          }
          else{
            expectedDate=_expectedDate.text;
          }
          if(_ordervalueSsl.text.isEmpty){
            ordervalueSsl=post.SSLValue.toString();
          }
          else{
            ordervalueSsl=_ordervalueSsl.text;
          }
          if(_risktype.text.isEmpty){
          rskType=post.Risk;
          }
          else{
          rskType=_risktype.text;
          }
          if(_propasolstatus.text.isEmpty){
          propasolStatus=post.ProposalStatus;
          }
          else{
            propasolStatus=_propasolstatus.text;
          }
          if( _submissionStatus.text.isEmpty){
          submissionStatus=post.SubmissionStatus;
          }
          else{
          submissionStatus=_submissionStatus.text;
          }
          if(_remark.text.isEmpty){
            remark=post.Remark;
          }
          else{
            remark=_remark.text;
          }
          if(_support.text.isEmpty){
            support=post.Support;
          }
          else{
            support=_support.text;
          }
          Navigator.of(context).pop(createAlbum(
              post.Lead_Id,
              projectName,
              expectedDate,
              ordervalueSsl,
              rskType,
              propasolStatus,
              submissionStatus,
              remark,
              support));
        },
        child: const Text('Update'),
      ),
    ],
  );
}

Future<String> createAlbum(
    int leadId,
    String projectName,
    String expceptedDate,
    String sSLvalue,
    String riskType,
    String proposalStatus,
    String submissionStatus,
    String remark,
    String support) async {
  final Map<String, dynamic> activityData = {
    'lead_id': leadId.toString(),
    'projectname': projectName,
    'exp_ord_date': expceptedDate,
    'ssl_value': sSLvalue.toString(),
    'risk': riskType,
    'proposal_status': proposalStatus,
    'submission_status': submissionStatus,
    'remark': remark,
    'support': support,
  };
  print(activityData.toString());
  var url = 'http://172.16.2.124:9090/updatelead/';
  var response = await http.post(Uri.parse(url), body: activityData);
  return response.body;
}
