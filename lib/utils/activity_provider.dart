import 'package:time_tracker/models/activity.dart';
import 'package:time_tracker/utils/constants.dart';
import 'package:time_tracker/utils/db_utils.dart';

class ActivityProvider{

  List<Activity> _activityList;
  DbUtils dbUtils;
  bool _somethingChanged;

  ActivityProvider(){
    _somethingChanged = true;
    dbUtils = DbUtils(tableName: DBConstants.ACTIVITY_TABLE_NAME);
  }

  Future<void> loadData() async {
    if(_somethingChanged){
      List res = await dbUtils.findAll();
      _activityList = res.isNotEmpty ? res.map((e) => Activity.fromMap(e)).toList() : <Activity>[];
      _somethingChanged = false;
    }
  }

  // GET OPERATIONS

  Future<List<Activity>> getAllActivity({bool active}) async {
    await loadData();

    return _activityList
        .where((activity){
          if(active == null) return true;
          return activity.active == active;
    }).toList();
  }

  Future<Activity> getActivity(int id) async {
    Map<String, dynamic> res = await dbUtils.findById(id);
    return res != null ? Activity.fromMap(res) : null;
  }

  // ADD OPERATIONS

  Future<Activity> addActivity(Activity activity) async {
    int id = await dbUtils.save(activity.toMap());
    _somethingChanged = true;
    await loadData();
    return await getActivity(id);
  }

  // UPDATE OPERATIONS

  Future<Activity> updateActivity(Activity activity) async {
    int id = await dbUtils.updateById(activity.id, activity.toMap());
    _somethingChanged = true;
    await loadData();
    return await getActivity(id);
  }

  // DELETE OPERATIONS

  Future<void> deleteActivityById(int id) async {
    await dbUtils.deleteById(id);
    _somethingChanged = true;
    await loadData();
  }

  Future<void> deleteAllActivity() async {
    await dbUtils.deleteAll();
    _somethingChanged = true;
    await loadData();
  }

}

ActivityProvider activityProvider = ActivityProvider();












