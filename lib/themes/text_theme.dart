import 'package:flutter/material.dart';

class MyTextTheme{
  static TextTheme light(double factor){
    return ThemeData.light().textTheme.copyWith(
      headline1: TextStyle(
        fontSize: 24.0*factor,
        fontWeight: FontWeight.bold,
        color: Colors.black
      ),
      headline2: TextStyle(
          fontSize: 24.0*factor,
          color: Colors.black
      ),
      headline3: TextStyle(
          fontSize: 20.0*factor,
          fontWeight: FontWeight.bold,
          color: Colors.black
      ),
      headline4: TextStyle(
          fontSize: 16.0*factor,
          fontWeight: FontWeight.bold,
          color: Colors.black
      ),
      headline5: TextStyle(
          fontSize: 12.0*factor,
          fontWeight: FontWeight.bold,
          color: Colors.black
      ),
      headline6: TextStyle(
          fontSize: 12.0*factor,
          color: Colors.black
      ),
      bodyText1: TextStyle(
        fontSize: 9.0*factor,
        color: Colors.black,
      ),
      bodyText2: TextStyle(
        fontSize: 7.0*factor,
        color: Colors.black,
      ),
    );
  }

  static TextTheme dark(double factor){
    return ThemeData.dark().textTheme.copyWith(
      headline1: TextStyle(
          fontSize: 24.0*factor,
          fontWeight: FontWeight.bold,
          color: Colors.white
      ),
      headline2: TextStyle(
          fontSize: 24.0*factor,
          color: Colors.white
      ),
      headline3: TextStyle(
          fontSize: 20.0*factor,
          fontWeight: FontWeight.bold,
          color: Colors.white
      ),
      headline4: TextStyle(
          fontSize: 16.0*factor,
          fontWeight: FontWeight.bold,
          color: Colors.white
      ),
      headline5: TextStyle(
          fontSize: 12.0*factor,
          fontWeight: FontWeight.bold,
          color: Colors.white
      ),
      headline6: TextStyle(
          fontSize: 12.0*factor,
          color: Colors.white
      ),
      bodyText1: TextStyle(
        fontSize: 9.0*factor,
        color: Colors.white,
      ),
      bodyText2: TextStyle(
        fontSize: 7.0*factor,
        color: Colors.white,
      ),
    );
  }

  static double get smallFont => 1.25;
  static double get mediumFont => 1.5;
  static double get largeFont => 2;
}

