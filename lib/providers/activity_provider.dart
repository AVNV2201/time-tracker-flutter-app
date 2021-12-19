import 'package:time_tracker/models/activity.dart';
import 'package:time_tracker/providers/action_provider.dart';
import 'package:time_tracker/utils/constants.dart';
import 'package:time_tracker/utils/db_utils.dart';

class ActivityProvider{

  final String _parentId = "parent_id";

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

  Future<List<Activity>> getAllActivity({
    bool active,
    bool filterParentWise: false,
    int parentId,
    bool sortOnUpdatedAt: true
  }) async {
    await loadData();

    List<Activity> res = _activityList
        .where((activity){
          if(active == null) return true;
          return activity.active == active;
    }).toList();

    if(filterParentWise){
      res = res
          .where((activity) => activity.parentId == parentId)
          .toList();
    }

    if(sortOnUpdatedAt){
      res.sort((a,b) => b.updatedAt.compareTo(a.updatedAt));
    }

    return res;
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

  Future<void> _deleteActivityByParentId(int parentId) async {
    List res = await dbUtils.findByFieldId(_parentId, parentId);
    if(res.isNotEmpty){
      res.map((e) => Activity.fromMap(e))
          .toList()
          .forEach((activity) {
            deleteActivityById(activity.id);
      });
    }
  }

  Future<void> deleteActivityById(int id) async {
    actionProvider.deleteActionByActivityId(id);
    _deleteActivityByParentId(id);
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












