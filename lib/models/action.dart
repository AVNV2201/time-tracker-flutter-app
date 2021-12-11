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

  factory Action.fromMap(Map<String, dynamic> json) => Action(
    id: json["id"],
    activityId: json["activityId"],
    start: json["start"],
    end: json["end"],
  );

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "activityId": activityId,
      "start": start,
      "end": end,
    };
    if( id != null)
      map["id"] = id;
    return map;
  }

}
