import 'package:newcrm/Database/UserDatabase.dart';
import 'package:newcrm/Model/employee.dart';
import 'package:newcrm/widget/customer_drawer.dart';
import 'package:newcrm/widget/syncappbar.dart';
import 'package:flutter/material.dart';
//import 'package:webview_flutter/webview_flutter.dart';
class WebViewContainer extends StatefulWidget {

  @override
  createState() => _WebViewContainerState();
}
Employee user;
class _WebViewContainerState extends State<WebViewContainer> {
  var _url="https://mail.google.com/mail/u/0/?tab=rm&ogbl#inbox";
  final _key = UniqueKey();
  _WebViewContainerState();

  GlobalKey<ScaffoldState> _globalkey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserDatabase.instance.getEmployee().then((result){
      setState(() {
        user = result;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalkey, // set it here
        appBar: SyncAppbar(_globalkey,"Gmail"),
        drawer: Drawer(
          child: Custom_Drawer(user),
        ),
        body: Column(
          children: [
            Expanded(
               /* child: WebView(
                    key: _key,
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: _url)*/)
          ],
        ));
  }
}
