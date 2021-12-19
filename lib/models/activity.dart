import 'package:time_tracker/utils/DateTimeUtils.dart';

class Activity {

  int id;
  int parentId;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  bool active;

  Activity({
    this.id,
    this.parentId,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.active,
  });

  factory Activity.createActivity(String name, int parentId) => Activity(
    name: name,
    parentId: parentId,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    active: true
  );

  factory Activity.fromMap(Map<String, dynamic> map) => Activity(
    id: map["id"],
    parentId: map["parent_id"],
    name: map["name"],
    createdAt: DateTimeUtils.fromSecondsEpoch(map["created_at"]),
    updatedAt: DateTimeUtils.fromSecondsEpoch(map["updated_at"]),
    active: map["active"] == 1,
  );

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "name": name,
      "parent_id": parentId,
      "created_at": DateTimeUtils.toSecondsEpoch(createdAt),
      "updated_at": DateTimeUtils.toSecondsEpoch(updatedAt),
      "active": active ? 1 : 0
    };
    if( id != null)
      map["id"] = id;
    return map;
  }

  @override
  String toString() {
    return 'Activity{id: $id, parentId: $parentId, name: $name, '
        'createdAt: $createdAt, updatedAt: $updatedAt, active: $active}';
  }
}
