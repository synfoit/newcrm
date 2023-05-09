import 'package:newcrm/Model/leaddata.dart';
import 'package:flutter/material.dart';



class Leadgenreted extends StatefulWidget{
  @override
  _LeadgenretedState createState() => _LeadgenretedState();
}

class _LeadgenretedState extends State<Leadgenreted> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reddit Application',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[300],
          centerTitle: true,
          title: Text(
            'Posts',
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: _buildBody(context),
      ),
    );
  }
  /*for (int i = 0; i < jsonResponsedata.length; i++) {
      //print(jsonResponsedata[i]);
      var rowdata = jsonResponsedata[i];
      LeadData leadDataM =
          rowdata.map<LeadData>((json) => LeadData.fromMap(json)).toList();
      print(leadDataM);
      //itemdat.add(leadDataM);
      print(rowdata);
      for (var data in rowdata) {
        LeadData leadata = LeadData(
            data["lead_id"],
            data["employeename"],
            data["customercode"],
            data["customername"],
            data["visit"],
            data["requirement"],
            data["projectname"],
            data["unit"],
            data["customertype"],
            data["industrytype"],
            data["clss"],
            data["meeting"],
            data["proposal_status"],
            data["submission_status"],
            data["sbu"],
            data["ssl_value"],
            data["oem_value"],
            data["exp_ord_date"],
            data["risk"],
            data["ssl_manager"],
            data["oem_manager"],
            data["di_manager"],
            data["remark"],
            data["support"],
            data["leadcreationDate"]);

        print('lead_id ${data["lead_id"]}');
        print('${data["customercode"]}');
        print('ustomername ${data["customername"]}');
        print('vist ${data["visit"]}');
        print('reqiuert ${data["requirement"]}');
        print('projectname${data["projectname"]}');
        print('unit${data["unit"]}');
        print('customertype ${data["customertype"]}');
        print("industrytype" + data["industrytype"]);
        print("clss" + data["clss"]);
        print("meeting" + data["meeting"]);
        print("di_manager" + data["di_manager"]);
        print("proposal_status" + data["proposal_status"]);
        print("remark" + data["remark"]);
        print("submission_status" + data["submission_status"]);
        print("sbu" + data["sbu"]);
        print("ssl_value" + data["ssl_value"]);
        print("oem_value" + data["oem_value"]);
        print("exp_ord_date" + data["exp_ord_date"]);
        print("risk" + data["risk"]);
        print("ssl_manager" + data["ssl_manager"]);
        print("oem_manager" + data["oem_manager"]);

        itemdat.add(leadDataM);
        *//* LeadData leadDataM=  rowdata.map<LeadData>((json) => LeadData.fromMap(json)).toList();
          print(leadDataM);*//*
        //itemdat.add(leadDataM);
        *//* if(rowdata[j]==null){

            }else{
              print(rowdata[j]);
            }
*//*
      }
    }*/
  /*for (var data in jsonResponsedata)
  {
    print('lead_id ${data["lead_id"]}');
    print('${ data["customercode"]}');
    print('ustomername ${ data["customername"] }');
    print('vist ${data["visit"]}');
    print('reqiuert ${data["requirement"]}');
    print('projectname${ data["projectname"]}');
    print('unit${ data["unit"]}');
    print('customertype ${data["customertype"]}');
    print("industrytype" + data["industrytype"]);
    print("clss" + data["clss"]);
    print("meeting" + data["meeting"]);
    print("di_manager" + data["di_manager"]);
    print("proposal_status" + data["proposal_status"]);
    print("remark" + data["remark"]);
    print("submission_status" + data["submission_status"]);
    print("sbu" + data["sbu"]);
    print("ssl_value" + data["ssl_value"]);
    print("oem_value" + data["oem_value"]);
    print("exp_ord_date" + data["exp_ord_date"]);
    print("risk" + data["risk"]);
    print("ssl_manager" + data["ssl_manager"]);
    print("oem_manager" + data["oem_manager"]);

    LeadData leadata = LeadData(
        data["lead_id"],
        data["employeename"],
        data["customercode"],
        data["customername"],
        data["visit"],
        data["requirement"],
        data["projectname"],
        data["unit"],
        data["customertype"],
        data["industrytype"],
        data["clss"],
        data["meeting"],
        data["proposal_status"],
        data["submission_status"],
        data["sbu"],
        data["ssl_value"],
        data["oem_value"],
        data["exp_ord_date"],
        data["risk"],
        data["ssl_manager"],
        data["oem_manager"],
        data["di_manager"],
        data["remark"],
        data["support"],
        data["leadcreationDate"]);
    itemdat.add(leadata);
  }*/

  FutureBuilder<List<LeadData>> _buildBody(BuildContext context) {
    //final client = RestClient(Dio(BaseOptions(contentType: "application/json")),"http://172.16.2.2:8080/restapi/getFunnelData/Bhavin Jani,Premal Patel,Praveen Singh,Parth Thakar,Utpal Rathod");
    return FutureBuilder<List<LeadData>>(

      //future: client.getTasks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<LeadData> posts = snapshot.data;
          return _buildPosts(context, posts);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView _buildPosts(BuildContext context, List<LeadData> posts) {
    return ListView.builder(
      itemCount: posts.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: ListTile(
            title: Text(
              posts[index].EmployeeName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(posts[index].CustomerName),
          ),
        );
      },
    );
  }


/*factory  LeadData.fromJson1(dynamic data){
     return LeadData(Lead_Id : data['lead_id'] as int,
       EmployeeName :data['employeename'] as String,
       CustomerCode :data['customercode'] as String,
       CustomerName :data['customername'] as String,
       Visit:data['visit'] as String,
       Requirement:data['requirement'] as String,
       ProjectName:data['projectname']as String,
       Unit:data['unit'] as String,
       CustomerType:data['customertype'] as String,
       IndustryType:data['industrytype'] as String,
       Clss:data['clss'] as String,
       Meeting:data['meeting'] as String,
       ProposalStatus:data['proposal_status'] as String,
       SubmissionStatus:data['submission_status'] as String,
       SBU:data['sbu'] as String,
       SSLValue:data['ssl_value'] as String,
       OEM_Value:data['oem_value'] as String,
       Exp_Ord_Date:data['exp_ord_date'] as String,
       Risk:data['risk'] as String,
       SSL_Manager:data['ssl_manager'] as String,
       OEM_Manager:data['oem_manager'] as String,
       Di_Manager:data['di_manager'] as String,
       Remark:data['remark'] as String,
       Support:data['support'] as String,
       LeadCreationDate:data['leadcreationDate'] as String,);
   }*/


/*late int customer_Id;
  late String customer_type;
  late String unit;
  late String customer;
  late String classname;
  late String project;
  late String purpose_of_visit;
  late String type_of_reqirment;
  late String type_of_meeting;
  late String proposal_status;
  late String proposal_submission_status;
  late String order_value_ssl;
  late String order_value_oem;
  late String expected_order_date;
  late String risk_type;
  late String user_name;
  late String oem_manger;
  late String support;
  late String remark;
*/
/* LeadData(this.customer,this.customer_type,this.classname,this.project,
  this.purpose_of_visit,this.type_of_reqirment,this.type_of_meeting,this.proposal_status,this.proposal_submission_status,
      this.order_value_ssl,this.order_value_oem,this.expected_order_date,this.risk_type,this.oem_manger,
      this.support,this.remark, this.customer_Id);



*/
/* LeadData.fromMap(Map map)
  {
    Lead_Id=map['lead_id'];
    EmployeeName=map['employeename'];
    CustomerCode=map['customercode'];
    CustomerName=map['customername'];
    Visit=map['visit'];
    Requirement=map['requirement'];
    ProjectName=map['projectname'];
    Unit=map['unit'];
    CustomerType=map['customertype'];
    IndustryType=map['industrytype'];
    Clss=map['clss'];
    Meeting=map['meeting'];
    ProposalStatus=map['proposal_status'];
    SubmissionStatus=map['submission_status'];
    SBU=map['sbu'];
    SSLValue=map['ssl_value'];
    OEM_Value=map['oem_value'];
    Exp_Ord_Date=map['exp_ord_date'];
    Risk=map['risk'];
    SSL_Manager=map['ssl_manager'];
    OEM_Manager=map['oem_manager'];
    Di_Manager=map['di_manager'];
    Remark=map['remark'];
    Support=map['support'];
    LeadCreationDate=map['leadcreationDate'];
  }*/
/*factory  LeadData.fromJson(Map<String, dynamic> data){
     return LeadData(data['lead_id'] as int,
       data['employeename'] as String,
       data['customercode'] as String,
     data['customername'] as String,
       data['visit'] as String,
    data['requirement'] as String,
    data['projectname']as String,
      data['unit'] as String,
     data['customertype'] as String,
     data['industrytype'] as String,
      data['clss'] as String,
       data['meeting'] as String,
      data['proposal_status'] as String,
    data['submission_status'] as String,
    data['sbu'] as String,
     data['ssl_value'] as String,
      data['oem_value'] as String,
     data['exp_ord_date'] as String,
     data['risk'] as String,
      data['ssl_manager'] as String,
      data['oem_manager'] as String,
    data['di_manager'] as String,
    data['remark'] as String,
   data['support'] as String,
     data['leadcreationDate'] as String,);
   }*/
}