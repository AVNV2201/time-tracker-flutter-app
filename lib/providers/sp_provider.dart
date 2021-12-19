import 'package:shared_preferences/shared_preferences.dart';

// SP = Shared preferences
class SPProvider{

  static Future<void> removeKey(String key) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove(key);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  static Future<void> saveString(String key, String value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(key, value);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  static Future<String> getString(String key) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(key) ?? null;
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<void> saveBool(String key, bool value ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(key, value);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  static Future<bool> getBool(String key) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool(key) ?? false;
    } on Exception catch (e) {
      print(e.toString());
      return false;
    }
  }

}