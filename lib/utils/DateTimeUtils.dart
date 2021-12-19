class DateTimeUtils{

  static int _sixty = 60;
  static int _sixtyIntoSixy = _sixty * _sixty;

  static int toSecondsEpoch(DateTime dateTime){
    if( dateTime == null) return null;
    return (dateTime.millisecondsSinceEpoch / 1000).round();
  }

  static DateTime fromSecondsEpoch(int seconds){
    if(seconds == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(seconds*1000);
  }

  static String format(int seconds){

    if(seconds <= 0)
      return "0:0:0";

    int s = seconds % _sixty;
    int m = (seconds / _sixty).round() % _sixty;
    int h = ( seconds / _sixtyIntoSixy ).round();

    return "$h:$m:$s";
  }

}