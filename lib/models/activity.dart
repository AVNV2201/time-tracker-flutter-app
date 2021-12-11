class Activity {

  int id;
  String name;
  DateTime createdAt;
  bool active;

  Activity({
    this.id,
    this.name,
    this.createdAt,
    this.active,
  });

  factory Activity.createActivity(String name) => Activity(
    name: name,
    createdAt: DateTime.now(),
    active: true
  );

  factory Activity.fromMap(Map<String, dynamic> json) => Activity(
    id: json["id"],
    name: json["name"],
    createdAt: json["createdAt"],
    active: json["active"],
  );

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "name": name,
      "createdAt": createdAt,
      "active": active,
    };
    if( id != null)
      map["id"] = id;
    return map;
  }

}
