import 'dart:convert';

import 'package:newcrm/Database/LeadDatabase.dart';
import 'package:newcrm/Model/lead_api_service.dart';
import 'package:newcrm/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class SyncAppbar extends StatefulWidget with PreferredSizeWidget {
  GlobalKey<ScaffoldState> globalKey;
  String title;
  SyncAppbar(this.globalKey,this.title);

  @override
  State<StatefulWidget> createState() => _SyncAppbarState(globalKey,title);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

}

class _SyncAppbarState extends State<SyncAppbar>
{
  GlobalKey<ScaffoldState> globalKey;
  String title;
  _SyncAppbarState(this.globalKey,this.title);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.primaryColor,
      elevation: 0.0,
      centerTitle: true,
      title: Text(title),
      leading: IconButton(
        icon: const Icon(Icons.menu),
        iconSize: 28.0,
        onPressed: () {
          globalKey.currentState.openDrawer();
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.notifications),
          iconSize: 28.0,
          onPressed: () {
            List<LeadDataSync> leadDataf;
            LeadDatabase.instance.getLeaddata().then((result){
               setState(() {
              leadDataf = result;
              for(int m=0;m<leadDataf.length;m++) {
                syndata(leadDataf[m]);
              }
            });
            });

          },
        ),
      ],
    );
  }


  Future<String> syndata(LeadDataSync leadDataf) async{
    var url = 'http://172.16.2.124:9090/addLead/';

    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:jsonEncode(leadDataf.toJson()),
    );
    if (response.statusCode == 200) {

      LeadDatabase.instance.updatestatus('sync', int.parse(response.body));
      return (response.body);
    } else {
      throw Exception('Failed to create album.');
    }
  }
}