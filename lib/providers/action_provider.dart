import 'package:time_tracker/models/action.dart';
import 'package:time_tracker/models/activity.dart';
import 'package:time_tracker/providers/activity_provider.dart';
import 'package:time_tracker/providers/db_provider.dart';
import 'package:time_tracker/utils/constants.dart';
import 'package:time_tracker/utils/db_utils.dart';

class ActionProvider{

  final String activityId = "activity_id";

  DbUtils dbUtils;

  ActionProvider(){
    dbUtils = DbUtils(tableName: DBConstants.ACTION_TABLE_NAME);
  }

  // INSERT OPERATIONS

  Future<bool> addAction(Action action) async {
    int id = await dbUtils.save(action.toMap());
    return id != null;
  }

  // GET OPERATIONS

  Future<int> _getActivityTime(int id, int from, int to) async {
    final db = await DBProvider.db.database;
    String table = DBConstants.ACTION_TABLE_NAME;
    String sql = "SELECT SUM(end-start) FROM $table WHERE activity_id=$id";
    if(from != null){
      sql += " AND start >= $from";
    }
    if(to != null){
      sql += " AND end <= $to";
    }
    var res = await db.rawQuery(sql);
    try{
      return res.first.values.first;
    }
    catch(e){
      print("Nothing found in query");
      return 0;
    }
  }

  Future<int> getActivityTotalTime(int id, int from, int to) async {
    int total = await _getActivityTime(id, from, to) ?? 0;
    List<Activity> activities = await activityProvider.getAllActivity(
      sortOnUpdatedAt: false,
      filterParentWise: true,
      parentId: id
    );
    if(activities != null){
      for(Activity a in activities)
        total += await getActivityTotalTime(a.id, from, to);
    }
    return total;
  }

  // DELETE OPERATIONS

  Future<void> deleteActionByActivityId(int id) async {
    await dbUtils.deleteById(id, fieldName: activityId);
  }

  Future<void> deleteAllAction() async {
    await dbUtils.deleteAll();
  }

}

final actionProvider = ActionProvider();