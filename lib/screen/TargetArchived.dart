import 'package:newcrm/Database/UserDatabase.dart';
import 'package:newcrm/Model/employee.dart';
import 'package:newcrm/config/palette.dart';
import 'package:newcrm/screen/pie_chart_page.dart';
import 'package:newcrm/widget/customer_drawer.dart';
import 'package:newcrm/widget/syncappbar.dart';
import 'package:newcrm/widget/targetandarchived.dart';
import 'package:flutter/material.dart';

Employee user;
class TargetArchived extends StatefulWidget {
  @override
  _TargetArchivedState createState() => _TargetArchivedState();

}

class _TargetArchivedState extends State<TargetArchived> {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserDatabase.instance.getEmployee().then((result){
      setState(() {
        user = result;
      });
    });}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : true,
      backgroundColor: Palette.primaryColor,
      key: _key, // set it here
      appBar: SyncAppbar(_key,"Target & Archived"),
      drawer: Drawer(
        child: Custom_Drawer(user),
      ),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverToBoxAdapter(
              child: PieChartPage(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 10.0,right: 10.0,left: 10.0,bottom: 10.0),
            sliver: SliverToBoxAdapter(
              child: TargetChartPage(),
            ),
          ),
        ],
      ),
    );
  }

}
