import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'SplashScreen.dart';
import 'package:newcrm/Database/DBHelper.dart';
import 'loginpage.dart';


class RouteSettngsPage extends RouteSettings{
  static RoutegenerateRoute(RouteSettings settings)
  {

    switch(settings.name)
    {
      case "/":
        return MaterialPageRoute(builder: (_)=>SplashPage());
        break;
      case "/splash":
        return MaterialPageRoute(builder: (_)=>SplashPage());
        break;
      case "/login":
        return MaterialPageRoute(builder: (_)=>LoginPage());
        break;
       case "/home":
        return MaterialPageRoute(builder: (_)=>HomeScreen());
        break;

    }
  }
}