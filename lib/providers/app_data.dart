import 'package:time_tracker/models/my_response.dart';
import 'package:time_tracker/themes/config.dart';
import 'package:time_tracker/utils/sp_manager.dart';

class AppData {
  static final AppData _appData = new AppData._internal();

  factory AppData() {
    return _appData;
  }
  AppData._internal();

  Future<MyResponse> loadData() async {
    try {
      // load the theme mode
      bool isDark = await SPManager.getThemeMode();
      if(isDark != currentTheme.isDarkTheme)
        currentTheme.toggleTheme(isDark);

      return MyResponse.success();
    } catch (e) {
      print(e.toString());
      if(e is MyResponse) return e;
    }
    return MyResponse.unknownError();

  }

  Future<void> resetAppData() async {

  }
}

final appData = AppData();
