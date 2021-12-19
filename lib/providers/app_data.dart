import 'package:time_tracker/models/action.dart';
import 'package:time_tracker/models/my_response.dart';
import 'package:time_tracker/themes/config.dart';
import 'package:time_tracker/providers/sp_provider.dart';
import 'package:time_tracker/utils/constants.dart';

class AppData {

  Action actionInProgress;

  static final AppData _appData = new AppData._internal();

  factory AppData() {
    return _appData;
  }
  AppData._internal();

  Future<MyResponse> loadData() async {
    try {
      // load the theme mode
      bool isDark = await SPProvider.getBool(SPKeys.THEME_KEY);
      if(isDark != currentTheme.isDarkTheme)
        currentTheme.toggleTheme(true);

      String jsonAction = await SPProvider.getString(SPKeys.ACTION_KEY);
      if(jsonAction != null && jsonAction.isNotEmpty){
        actionInProgress = Action.fromJson(jsonAction);
      }
      else{
        actionInProgress = null;
      }

      return MyResponse.success();
    } catch (e) {
      print(e.toString());
      if(e is MyResponse) return e;
    }
    return MyResponse.unknownError();

  }

  void saveAppData(){
    if(actionInProgress != null){
      SPProvider.saveString(SPKeys.ACTION_KEY, actionInProgress.toJson());
    }
  }

  Future<void> resetAppData() async {

  }

  void resetAction(){
    actionInProgress = null;
    SPProvider.removeKey(SPKeys.ACTION_KEY);
  }
}

final appData = AppData();
