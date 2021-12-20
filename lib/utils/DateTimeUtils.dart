import 'package:time_tracker/widgets/my_date_range_picker.dart';

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

  static String formatDate(DateTime d){
    return "${d.day}-${d.month}-${d.year}";
  }

  static String format(int seconds){

    if(seconds <= 0)
      return "0:0:0";

    int s = seconds % _sixty;
    int m = (seconds / _sixty).floor() % _sixty;
    int h = ( seconds / _sixtyIntoSixy ).floor();

    return "$h:$m:$s";
  }

  static List getDayRange(DateTime date){
    if(date == null) date = DateTime.now();
    return [getMinDayTime(date),getMaxDayTime(date), RangeType.DAY];
  }

  static List getLast7DaysRange(){
    DateTime now = DateTime.now();
    DateTime start = DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: 6));
    DateTime end = getMaxDayTime(now);
    return [start,end, RangeType.WEEK];
  }

  static List getThisMonthRange(){
    DateTime now = DateTime.now();
    DateTime start = DateTime(now.year, now.month);
    DateTime end = getMaxDayTime(now);
    return [start,end, RangeType.MONTH];
  }

  static List getThisYearRange(){
    DateTime now = DateTime.now();
    DateTime start = DateTime(now.year);
    DateTime end = getMaxDayTime(now);
    return [start,end, RangeType.YEAR];
  }

  static DateTime getMinDayTime(DateTime dateTime){
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  static DateTime getMaxDayTime(DateTime dateTime){
    return DateTime(dateTime.year, dateTime.month, dateTime.day)
        .add(Duration(days: 1))
        .subtract(Duration(seconds: 1));
  }

}