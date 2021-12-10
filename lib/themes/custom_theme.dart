import 'package:flutter/material.dart';
import 'package:time_tracker/themes/text_theme.dart';

class CustomTheme with ChangeNotifier{

  double myFontSize = MyTextTheme.mediumFont;
  bool isCompact = false;
  bool isDarkTheme = false;
  // bool isDarkTheme = true;
  ThemeMode get currentTheme => isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme(bool value) {
    isDarkTheme = value;
    notifyListeners();
  }

  void toggleCardType(bool value) {
    isCompact = value;
    notifyListeners();
  }

  void setFontSize(double value){
    myFontSize = value;
    notifyListeners();
  }

  ThemeData get lightTheme{
    return ThemeData.light().copyWith(
      primaryColor: Colors.blue,
      backgroundColor: Colors.blue[300],
      scaffoldBackgroundColor: Colors.blue[100],
      cardColor: Colors.blue,
      textTheme: MyTextTheme.light(myFontSize),
      shadowColor: Colors.blue[800],
      dividerColor: Colors.grey,
      tabBarTheme: TabBarTheme(
        labelColor: Colors.blue[900],
        unselectedLabelColor: Colors.blue[700],
        indicator: BoxDecoration(
          color: Colors.blue[200],
          border: Border.all(
            color: Colors.blue[700],
            width: 5.0,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: Colors.blue[700],
          onPrimary: Colors.white,
        ),
      ),
    );
  }

  ThemeData get darkTheme{
    return ThemeData.dark().copyWith(
      backgroundColor: Colors.blue[800],
      cardColor: Colors.blue[900],
      textTheme: MyTextTheme.dark(myFontSize),
      shadowColor: Colors.blue,
      dividerColor: Colors.grey,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: Colors.blue[700],
          onPrimary: Colors.white,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.black,
        contentTextStyle: TextStyle(color: Colors.white),
      ),
      tabBarTheme: TabBarTheme(
        indicator: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            color: Colors.white,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}






