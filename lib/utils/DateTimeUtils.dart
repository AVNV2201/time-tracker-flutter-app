class DateTimeUtils{

  static int toSecondsEpoch(DateTime dateTime){
    if( dateTime == null) return null;
    return (dateTime.millisecondsSinceEpoch / 1000).round();
  }

  static DateTime fromSecondsEpoch(int seconds){
    if(seconds == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(seconds*1000);
  }

}