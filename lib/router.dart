import 'package:flutter/material.dart';
import 'package:time_tracker/pages/splash.dart';

class MyRouter{

  static Route<dynamic> generateRoute(RouteSettings settings){

    String name = settings.name;
    String route, param;
    int index = name.substring(1).indexOf('/');
    if(index == -1 ){
      route = name;
      param = '';
    }
    else{
      index++;
      route = name.substring(0,index);
      param = name.substring(index+1);
    }

    print(param);

    switch(route){
      // case Home.routeName:
      //   return MaterialPageRoute(builder: (_) => Home() );
      case Splash.routeName:
        return MaterialPageRoute(builder: (_) => Splash());
      // case Profile.routeName:
      //   return MaterialPageRoute(builder: (_) => Profile(username: param,));

    }
    return null;
  }
}