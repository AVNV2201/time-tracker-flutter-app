import 'package:time_tracker/models/action.dart';
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

  // DELETE OPERATIONS

  Future<void> deleteActionByActivityId(int id) async {
    await dbUtils.deleteById(id, fieldName: activityId);
  }

  Future<void> deleteAllAction() async {
    await dbUtils.deleteAll();
  }

}

final actionProvider = ActionProvider();