import 'package:newcrm/Database/UserDatabase.dart';
import 'package:newcrm/Model/employee.dart';
import 'package:newcrm/widget/syncappbar.dart';
import 'package:flutter/material.dart';
import 'package:newcrm/config/palette.dart';
import 'package:newcrm/widget/customer_drawer.dart';
//import 'package:syncfusion_flutter_gauges/gauges.dart';

Employee user;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    UserDatabase.instance.getEmployee().then((result) {
      setState(() {
        user = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _key, // set it here
      appBar: SyncAppbar(_key, "Dashboard"),
      drawer: Drawer(
        child: Custom_Drawer(user),
      ),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildHeader(screenHeight, user.userName),
          _buildPreventionTips(screenHeight),
          //_buildYourOwnTest(screenHeight),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildHeader(double screenHeight, String userName) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: Palette.primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Dashboard:[2021-2020]',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Employee Detail',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: screenHeight * 0.01),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: screenHeight * 0.01),
                            const Text(
                              'Name',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 15.0,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            const Text(
                              'Team Name',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 15.0,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            const Text(
                              'TL',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 15.0,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            const Text(
                              'SAM',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 15.0,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            const Text(
                              'Name',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 15.0,
                              ),
                            ),
                          ]),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Column(children: <Widget>[
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          'Khyati Surve',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        const Text(
                          'Khyati Surve',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        const Text(
                          'Khyati Surve',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        const Text(
                          'Khyati Surve',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        const Text(
                          'Khyati Surve',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 15.0,
                          ),
                        ),
                      ])
                    ])
              ],
            )
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildPreventionTips(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        width: 400.0,
        margin: const EdgeInsets.only(top: 20.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.white,
          elevation: 10,
          // child: Column(
          // margin: const EdgeInsets.only(top: 20.0),
         /* child: SfRadialGauge(axes: <RadialAxis>[
            RadialAxis(minimum: 0, maximum: 100, ranges: <GaugeRange>[
              GaugeRange(startValue: 0, endValue: 20, color: Colors.red),
              GaugeRange(startValue: 20, endValue: 40, color: Colors.orange),
              GaugeRange(startValue: 40, endValue: 60, color: Colors.yellow),
              GaugeRange(startValue: 60, endValue: 80, color: Colors.green),
              GaugeRange(startValue: 80, endValue: 100, color: Colors.blue)
            ], pointers: <GaugePointer>[
              const NeedlePointer(value: 90)
            ], annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  widget: Container(
                      child: const Text('90.0',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold))),
                  angle: 90,
                  positionFactor: 0.5)
            ])
          ]),*/
        ),
        //   ),
      ),
    );
  }

  SliverToBoxAdapter _buildYourOwnTest(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        padding: const EdgeInsets.all(10.0),
        height: screenHeight * 0.15,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFAD9FE4), Palette.primaryColor],
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Image.asset('assets/images/own_test.png'),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Do your own test!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                const Text(
                  'Follow the instructions\nto do your own test.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                  maxLines: 2,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
