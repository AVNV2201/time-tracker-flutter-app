import 'package:flutter/material.dart';
import 'package:time_tracker/pages/splash.dart';
import 'package:time_tracker/router.dart';
import 'package:time_tracker/themes/config.dart';
import 'package:time_tracker/providers/app_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    appData.loadData();
    currentTheme.addListener(() {
      setState(() {
        // to trigger the build
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Tracker',
      theme: currentTheme.lightTheme,
      darkTheme: currentTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
      initialRoute: Splash.routeName,
      onGenerateRoute: MyRouter.generateRoute,
    );
  }
}

