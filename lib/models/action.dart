import 'dart:convert';

import 'package:time_tracker/utils/DateTimeUtils.dart';

class Action {

  int id;
  int activityId;
  DateTime start;
  DateTime end;

  Action({
    this.id,
    this.activityId,
    this.start,
    this.end,
  });

  factory Action.createAction(int activityId) => Action(
    activityId: activityId,
    start: DateTime.now()
  );

  factory Action.fromMap(Map<String, dynamic> map) => Action(
    id: map["id"],
    activityId: map["activity_id"],
    start: DateTimeUtils.fromSecondsEpoch(map["start"]),
    end: DateTimeUtils.fromSecondsEpoch(map["end"]),
  );

  factory Action.fromJson(String json) => Action.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "activity_id": activityId,
      "start": DateTimeUtils.toSecondsEpoch(start),
      "end": DateTimeUtils.toSecondsEpoch(end),
    };
    if( id != null)
      map["id"] = id;
    return map;
  }

  String toJson() => jsonEncode(toMap());

  @override
  String toString() {
    return 'Action{id: $id, activityId: $activityId, start: $start, end: $end}';
  }
}
