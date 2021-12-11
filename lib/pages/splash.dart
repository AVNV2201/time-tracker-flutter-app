import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:time_tracker/models/my_response.dart';
import 'package:time_tracker/pages/home.dart';
import 'package:time_tracker/providers/app_data.dart';
import 'package:time_tracker/widgets/app_logo.dart';
import 'package:time_tracker/widgets/my_dialogs.dart';

class Splash extends StatefulWidget {

  static const String routeName = '/';

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  void _loadData() async {

    MyResponse myResponse = await appData.loadData();

    if(myResponse.success)
      Navigator.pushReplacementNamed(context, Home.routeName);
    else
      MyDialogs.showErrorDialog(context);


  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.blue[900],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Container(),),
            AppLogo(
              padding: 10.0,
              fontSize: width*0.12,
            ),
            Expanded(child: Container(),),
            SpinKitPulse(
              color: Colors.white,
              size: width * 0.15,
            ),
            Text(
              'Loading data...',
              style: TextStyle(
                fontSize: width * 0.05,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(height*0.02),
              child: FlutterLogo(size: height*0.05,),
            ),
          ],
        ),
      ),
    );
  }
}
