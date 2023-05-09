import 'dart:convert';
import 'dart:io';
import 'package:newcrm/Database/CustomerNameDatabase.dart';
import 'package:newcrm/Database/CustomerTypeDatabase.dart';
import 'package:newcrm/Database/IndustryNameDatabase.dart';
import 'package:newcrm/Database/LeadDatabase.dart';
import 'package:newcrm/Database/UserDatabase.dart';
import 'package:newcrm/Model/CustomerType.dart';
import 'package:newcrm/Model/IndustryType.dart';
import 'package:newcrm/Model/employee.dart';
import 'package:newcrm/Model/leaddata.dart';
import 'package:newcrm/config/ServerIp.dart';
import 'package:newcrm/config/palette.dart';
import 'package:newcrm/widget/customer_drawer.dart';
import 'package:newcrm/widget/syncappbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'ViewFunnelData.dart';

class LeadForm extends StatefulWidget {
  @override
  _LeadFromState createState() => _LeadFromState();
}

 Future<List<String>> fetGetCustomerType;
 Future<List<String>> fetGetcustomerName;
 Future<List<String>> fetGetIndustryType;
 Future<List<String>> getCustomerNamelist;
 Future<List<String>> getCustomerType;
 Future<List<String>> getIndustryType;

 Future<String> customerCodedata;
 Future<String> customerCode;
Employee leaduser;

Future<List<String>> fetchAlbumGetCustomerName() async {
  List<String> customerName = [];
  final responsecustomer =
      await http.get(Uri.parse("http://172.16.2.124:9090/getCustomerName"));
  stdout.writeln(responsecustomer);
  if (responsecustomer.statusCode == 200) {
    var customerNamelist = json.decode(responsecustomer.body);
    for (var k in customerNamelist) {
      customerName.add(k);

    }


    return customerName;
  } else {
    throw Exception('Failed to load album');
  }
}

Future<List<String>> fetchAlbumGetCustomerType() async {
  List<String> customerType = [];
  final responseCustomerType =
      await http.get(Uri.parse("http://172.16.2.124:9090/getCustomerType"));
  stdout.writeln(responseCustomerType);
  if (responseCustomerType.statusCode == 200) {
    var customerNametype = json.decode(responseCustomerType.body);
    for (var k in customerNametype) {
      customerType.add(k);
      CustomerTypeDatabase.instance.insertcustomertype(k);
    }

    return customerType;
  } else {
    throw Exception('Failed to load album');
  }
}

Future<List<String>> fetchAlbumGetIndustryType() async {
  List<String> industyType = [];
  final responseIndustrytype =
      await http.get(Uri.parse("http://172.16.2.124:9090/getIndustryType"));
  stdout.writeln(responseIndustrytype);
  if (responseIndustrytype.statusCode == 200) {
    var industrytype = json.decode(responseIndustrytype.body);
    for (var k in industrytype) {
      industyType.add(k);
      IndustryNameDatabase.instance.insertindustrytype(k);
    }


    return industyType;
  } else {
    throw Exception('Failed to load album');
  }
}

Future<String> fetchAlbumGetCustomerCode(String customerName) async {
  final response = await http.get(
      Uri.parse("http://172.16.2.124:9090/getCustomercode/" + customerName));
  stdout.writeln(response.body);

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

class _LeadFromState extends State<LeadForm> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String dropdownvalue = 'Apple';


  String puposeofvisit = 'RFQ';
  String typerequirement = 'Firm';
  String typemeeting = 'online';
  String proposalstatus = 'LIVE';
  String risktype = 'Low';
  String submittedstatus = 'SUBMITTED';
  String _customerType = "END USER";
  String _industryName = "Auto";
  String _customerNameCode = "101";
  String _customerName = "AARTI INDUSTRIES LIMITED";
  var puposeOfVisitItem = [
    'RFQ',
    'ENQ',
    'LEAD',
    'COURTESY',
    'PAYMENT FOLLOW UP'
  ];
  var typeOfRequirement = ['Firm', 'Budgetry'];
  var typeOfMeeting = ['online', 'offline'];
  var proposalStatus = ['LIVE', 'WIN', 'LOST', 'SKIP', 'NONE'];
  var riskType = ['Low', 'Medium', 'High'];
  var submittedStatus = ['SUBMITTED', 'NOT SUBMITTED'];
  String newValue = "";

  TextEditingController _project = TextEditingController();
  TextEditingController _classname = TextEditingController();
  TextEditingController _unit = TextEditingController();
  TextEditingController _ordervalueSsl = TextEditingController();
  TextEditingController _ordervalueOem = TextEditingController();
  TextEditingController _expectedDate = TextEditingController();
  TextEditingController _oemManager = TextEditingController();
  TextEditingController _support = TextEditingController();
  TextEditingController _remark = TextEditingController();
  TextEditingController _diManager = TextEditingController();
  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  @override
  void initState() {
    super.initState();
    UserDatabase.instance.getEmployee().then((result) {
      setState(() {
        leaduser = result;
      });
    });

    customerCodedata=CustomerNameDatabase.instance.getCustomerCode(_customerName);

  }

  @override
  Widget build(BuildContext context) {
    String _setDate;
    DateTime currentDate = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    Future<void> _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: currentDate,
          initialDatePickerMode: DatePickerMode.day,
          firstDate: DateTime(2015),
          lastDate: DateTime(2101));
      if (picked != null)
        setState(()
        {
          currentDate = picked;
          _expectedDate.text =formatter.format(currentDate);
        });
    }

    final addlead = Material(

      elevation: 5.0,
      color: Palette.primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: _submit,
        child: Text("Add Lead",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    return Scaffold(
        key: _key, // set it here
        appBar: SyncAppbar(_key,"ADD Lead"),
        drawer: Drawer(
          child: Custom_Drawer(leaduser),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
                key: _formkey,
                child: Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          padding:
                          const EdgeInsets.only(top: 35, right: 10, left: 10),
                          child: Flexible(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                //Expanded(child:
                                Material(
                                  child: _buildcustomernameBody(context),
                                  // )
                                )
                              ]))),
                      Container(
                        margin: const EdgeInsets.only(top: 10,right: 10,left: 10),
                        alignment: Alignment.centerLeft,
                        decoration: const BoxDecoration(),
                        child: _buildcustomernameCodeBody(context),
                      ),

                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: _unit,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Unit',
                            hintText: 'Enter Unit',
                          ),

                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildcustomertypeBody(context),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildindustrynameBody(context),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: _classname,
                          decoration: const InputDecoration(
                            border:  OutlineInputBorder(),
                            labelText: 'Class',
                            hintText: 'Enter Class',
                          ),

                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: _project,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Project',
                            hintText: 'Enter Project',
                          ),

                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DropdownButtonFormField(
                                value: puposeofvisit,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: puposeOfVisitItem.map((String items) {
                                  return DropdownMenuItem(
                                      value: items, child: Text(items));
                                }).toList(),
                                hint: const Text(
                                  "Purpose of visit",
                                  style:  TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Purpose of visit',
                                  hintText: 'Purpose of visit',
                                ),

                                onChanged: (newValue) {
                                  setState(() {
                                    puposeofvisit = newValue.toString();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DropdownButtonFormField(
                                value: typerequirement,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: typeOfRequirement.map((String items) {
                                  return DropdownMenuItem(
                                      value: items, child: Text(items));
                                }).toList(),
                                hint: const Text(
                                  "Type of Requirement",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Type of Requirement',
                                  hintText: 'Type of Requirement',
                                ),

                                onChanged: (newValue) {
                                  setState(() {
                                    typerequirement = newValue.toString();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DropdownButtonFormField(
                                value: typemeeting,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: typeOfMeeting.map((String items) {
                                  return DropdownMenuItem(
                                      value: items, child: Text(items));
                                }).toList(),
                                hint: const Text(
                                  "Type of Meeting",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),

                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Type of Meeting',
                                  hintText: 'Type of Meeting',
                                ),
                                onChanged: (newValue) {
                                  setState(() {
                                    dropdownvalue = newValue.toString();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DropdownButtonFormField(
                                value: proposalstatus,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: proposalStatus.map((String items) {
                                  return DropdownMenuItem(
                                      value: items, child: Text(items));
                                }).toList(),
                                hint: const Text(
                                  "Proposal Status",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Proposal Status',
                                  hintText: 'Proposal Status',
                                ),

                                onChanged: (newValue) {
                                  setState(() {
                                    proposalstatus = newValue.toString();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DropdownButtonFormField(
                                value: submittedstatus,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: submittedStatus.map((String items) {
                                  return DropdownMenuItem(
                                      value: items, child: Text(items));
                                }).toList(),
                                hint: const Text(
                                  "Proposal Submission Status",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Proposal Submission Status',
                                  hintText: 'Proposal Submission Status',
                                ),

                                onChanged: (newValue) {
                                  setState(() {
                                    submittedstatus = newValue.toString();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: _ordervalueSsl,
                          decoration: const InputDecoration(
                            border:  OutlineInputBorder(),
                            labelText: 'Order value on ss[in.las]',
                            hintText: 'Enter Order value on ss[in.las]',
                          ),

                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: _ordervalueOem,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Order value on OEM[in.las]',
                            hintText: 'Enter Order value on OEM[in.las]',
                          ),
                          //onSaved: (val) => this.order_value_oem != val,
                        ),
                      ),

                      const Text(
                        'Expected order Date',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5),
                      ),
                      InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Container(
                          margin:  const EdgeInsets.only(top: 10,right: 10,left: 10),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(color: Colors.grey[200]),
                          child: TextFormField(
                            style: const TextStyle(fontSize: 20),
                            textAlign: TextAlign.start,
                            enabled: false,
                            keyboardType: TextInputType.text,
                            controller: _expectedDate,
                            onSaved: (String val) {
                              _setDate = val;
                            },
                            decoration: const InputDecoration(

                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.access_alarms),
                                ),

                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DropdownButtonFormField(
                                value: risktype,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: riskType.map((String items) {
                                  return DropdownMenuItem(
                                      value: items, child: Text(items));
                                }).toList(),
                                hint: const Text(
                                  "Risk Type",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                // onSaved: (val) => this.risk_type != val,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Risk Type',
                                  hintText: 'Risk Type',
                                ),
                                onChanged: (newValue) {
                                  setState(() {
                                    risktype = newValue.toString();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10,right: 10,left: 10),
                        alignment: Alignment.centerLeft,
                        decoration: const BoxDecoration(),
                        child: TextFormField(
                          style: const TextStyle(fontSize: 20),
                          textAlign: TextAlign.start,
                          enabled: false,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(

                             labelText: leaduser.userName,
                            border: const OutlineInputBorder(),

                          ),

                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: _oemManager,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'OEM A/C amanager',
                            hintText: 'Enter OEM A/C amanager',
                          ),


                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: _diManager,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Di A/C amanager',
                            hintText: 'Enter Di A/C amanager',
                          ),
                          //onSaved: (val) => this.oem_manger != val,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: _remark,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Remark',
                            hintText: 'Enter Remark',
                          ),

                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: _support,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Support',
                            hintText: 'Enter Support',
                          ),

                        ),
                      ),
              Container(
                padding: const EdgeInsets.all(10),
              child: addlead,),

                    ],
                  ),
                )),
          ),
        ));
  }

  FutureBuilder<List<String>> _buildcustomernameBody(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: CustomerNameDatabase.instance.getCustomerName(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<String> posts = snapshot.data;
          return _buildcustomernamePosts(context, posts);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  DropdownButtonFormField _buildcustomernamePosts(
      BuildContext context, List<String> customername) {
    // _customerName=customername[0];
    return DropdownButtonFormField(
      value: _customerName,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: customername.map((String items) {
        return DropdownMenuItem(
            value: items,
            child: Flexible(
            child:Expanded(
            child: Text(items)
            //   )
             )

            )
            );
      }).toList(),
      hint: const Text(
        "Select Customer",
        style: TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
      ),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Select Customer',
        hintText: 'Select Customer',
      ),
      //onSaved: (val) => this.customer != val,
      onChanged: (newValue) {
        setState(() {
          _customerName = newValue.toString();
          customerCode = fetchAlbumGetCustomerCode(newValue.toString());
          customerCodedata=CustomerNameDatabase.instance.getCustomerCode(newValue.toString());
          //_customerNameCode=newValue.toString();
        });
      },
    );
  }

  FutureBuilder<List<CustomerType>> _buildcustomertypeBody(BuildContext context) {
    return FutureBuilder<List<CustomerType>>(
      future: CustomerTypeDatabase.instance.getCustomerType(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<CustomerType> posts = snapshot.data;
          return _buildcustomertypePosts(context, posts);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  DropdownButtonFormField _buildcustomertypePosts(
      BuildContext context, List<CustomerType> customertype) {
    // String _customerType=customertype[0];
    return DropdownButtonFormField(
      value: _customerType,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: customertype.map((CustomerType items) {
        return DropdownMenuItem(value: items.customertype, child: Text(items.customertype));
      }).toList(),
      hint: const Text(
        "Select Customer Type",
        style: TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
      ),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Select Customer Type',
        hintText: 'Select Customer Type',
      ),
      //onSaved: (val) => this.customer != val,
      onChanged: (newValue) {
        setState(() {
          _customerType = newValue.toString();
        });
      },
    );
  }

  FutureBuilder<List<IndustryType>> _buildindustrynameBody(BuildContext context) {
    return FutureBuilder<List<IndustryType>>(
      future: IndustryNameDatabase.instance.getIndustryType(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<IndustryType> posts = snapshot.data;
          return _buildindustrynamePosts(context, posts);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  DropdownButtonFormField _buildindustrynamePosts(
      BuildContext context, List<IndustryType> industryname) {
    return DropdownButtonFormField(
      value: _industryName,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: industryname.map((IndustryType items) {
        return DropdownMenuItem(value: items.industryname, child: Text(items.industryname));
      }).toList(),
      hint: const Text(
        "Select Industry Type",
        style: TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
      ),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Select Industry Type',
        hintText: 'Select Industry Type',
      ),
      onChanged: (newValue) {
        setState(() {
          _industryName = newValue.toString();
        });
      },
    );
  }

  FutureBuilder<String> _buildcustomernameCodeBody(BuildContext context) {
    return FutureBuilder<String>(
        future: customerCodedata,
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            _customerNameCode=snapshot.data;
            return
              TextFormField(
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.start,
                  enabled: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText:'Customer Code: ' + snapshot.data,
                    border: const OutlineInputBorder(),
                  )
              );

          } else if (snapshot.hasError) {
            return const Text('Customer Code 1000');
          }
          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        });
  }

  Future<void> _submit() async {

    var now =  DateTime.now();
    var formatter =  DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        createAlbum(
            leaduser.userName,
            _customerNameCode,
            _customerName,
            puposeofvisit,
            typerequirement,
            _project.text,
            _unit.text,
            _customerType,
            _industryName,
            _classname.text,
            typemeeting,
            proposalstatus,
            submittedstatus,
            '',
            _ordervalueSsl.text,
            _ordervalueOem.text,
            _expectedDate.text,
            risktype,
            leaduser.userName,
            _oemManager.text,
            _diManager.text,
            _support.text,
            _remark.text,
            formattedDate);

      }
    } on SocketException catch (_) {

      LeadDatabase.instance.insertLead( 0,
          leaduser.userName,
          _customerNameCode,
          _customerName,
          puposeofvisit,
          typerequirement,
          _project.text,
          _unit.text,
          _customerType,
          _industryName,
          _classname.text,
          typemeeting,
          proposalstatus,
          submittedstatus,
          '',
          int.parse(_ordervalueSsl.text),
          int.parse(_ordervalueOem.text),
          _expectedDate.text,
          risktype,
          leaduser.userName,
          _oemManager.text,
          _diManager.text,
          _remark.text,
          _support.text,
          formattedDate,'not_sync');
    }


    _showSnackBar("Data saved successfully");
    Navigator.push(
      context,
       MaterialPageRoute(builder: (context) =>  ViewFunnelData()),
    );
  }

  void _showSnackBar(String text) {

  //  _key.currentState!.showSnackBar( SnackBar(content:  Text(text)));
  }

  void navigateToEmployeeList() {
    Navigator.push(
      context,
       MaterialPageRoute(builder: (context) =>  ViewFunnelData()),
    );
  }

  Future<String> createAlbum(
      String employeename,
      String customerNameCode,
      String customerName,
      String puposeofvisit,
      String typerequirement,
      String project,
      String unit,
      String customerType,
      String industryName,
      String classname,
      String typemeeting,
      String proposalstatus,
      String submittedstatus,
      String sbu,
      String ordervalueSsl,
      String ordervalueOem,
      String expectedDate,
      String risktype,
      String sslmaanger,
      String oemManager,
      String diManager,
      String support,
      String remark,
      String datetoday) async {
    var url = ServerIp.serverip+'/addLead/';
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'lead_id': '0',
        'employeename': employeename,
        'customercode': customerNameCode,
        'customername': customerName,
        'visit': puposeofvisit,
        'requirement': typerequirement,
        'projectname': project,
        'unit': unit,
        'customertype': customerType,
        'industrytype': industryName,
        'clss': classname,
        'meeting': typemeeting,
        'proposal_status': proposalstatus,
        'submission_status': submittedstatus,
        'sbu': sbu,
        'ssl_value': ordervalueSsl,
        'oem_value': ordervalueOem,
        'exp_ord_date': expectedDate,
        'risk': risktype,
        'ssl_manager': sslmaanger,
        'oem_manager': oemManager,
        'di_manager': diManager,
        'remark': remark,
        'support': support,
        'leadcreationDate': datetoday
      }),
    );
    if (response.statusCode == 200) {
      return (json.decode(response.body));
    } else {
      throw Exception('Failed to create album.');
    }
  }
/*
  FutureBuilder<List<LeadData>> _buildleaddata(BuildContext context) {
    return FutureBuilder<List<LeadData>>(
      future:LeadDatabase.instance.getLeaddata(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<LeadData>? posts = snapshot.data;
          return syndata(context, posts!);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }*/



  Future<String> syndata(LeadData leadDataf) async{
    var url = ServerIp.serverip+'restapi/addLead/';
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:jsonEncode(leadDataf.toJson()),
    );
    if (response.statusCode == 200) {
      return (json.decode(response.body));
    } else {
      throw Exception('Failed to create album.');
    }
  }

}
