import 'package:shared_preferences/shared_preferences.dart';

// SP = Shared preferences
class SPManager{

  static final String themeKey = 'tmk';

  // persisting theme mode
  // true => dark mode
  // false => light mode
  static Future<void> saveThemeMode( bool isDark ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(themeKey, isDark);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  static Future<bool> getThemeMode() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool(themeKey) ?? false;
    } on Exception catch (e) {
      print(e.toString());
      return false;
    }
  }

}