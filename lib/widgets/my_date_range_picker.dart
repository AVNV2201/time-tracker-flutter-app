import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:time_tracker/utils/DateTimeUtils.dart';
import 'package:time_tracker/widgets/my_dialogs.dart';

class MyDateRange extends StatefulWidget {

  final Function(DateTime from, DateTime to, RangeType rangeType) onDateChanged;
  final RangeType rangeType;
  final DateTime from;
  final DateTime to;
  final double height, width;
  final String defaultTitle;

  MyDateRange({
    Key key,
    this.onDateChanged,
    this.rangeType,
    this.from,
    this.to,
    this.height: 24,
    this.width: 180,
    this.defaultTitle: "No Selection",
  }) : super(key: key);

  @override
  _MyDateRangeState createState() => _MyDateRangeState();
}

class _MyDateRangeState extends State<MyDateRange> {

  DateTime _from, _to;
  RangeType _rangeType;

  @override
  void initState() {
    _from = widget.from;
    _to = widget.to;
    _rangeType = widget.rangeType;
    super.initState();
  }

  String _getTitle(){
    if(_rangeType == RangeType.DAY)
      return DateTimeUtils.formatDate(_from);
    else if(_rangeType == RangeType.CUSTOM)
      return "Custom Range Selected";
    else if(_isWorkableRangeType())
      return "${DateTimeUtils.formatDate(_from)} to ${DateTimeUtils.formatDate(_to)}";
    return widget.defaultTitle;
  }

  void _onArrowTap(bool isLeft){
    Duration duration;
    if(_rangeType == RangeType.DAY) {
      duration = Duration(days: 1);
    }
    else if(_rangeType == RangeType.WEEK) {
      duration = Duration(days: 7);
    }
    else if(_rangeType == RangeType.MONTH) {
      duration = Duration(days: 30);
    }
    else if(_rangeType == RangeType.YEAR) {
      duration = Duration(days: 365);
    }
    if(duration != null){
      DateTime f, t;
      if(isLeft){
        f = _from.subtract(duration);
        t = _to.subtract(duration);
      }
      else{
        f = _from.add(duration);
        t = _to.add(duration);
      }
      setState(() {
        _from = f;
        _to = t;
      });
      _runCallback();
    }
  }
  
  void _runCallback(){
    widget.onDateChanged(_from, _to, _rangeType);
  }

  void _selectRange() async {
    List res = await _showRangeSelectionDialog();
    if(res != null && res.length == 3){
      setState(() {
        _from = res[0];
        _to = res[1];
        _rangeType = res[2];
      });
      _runCallback();
    }
  }

  bool _isWorkableRangeType() {
    if (_rangeType != null && _rangeType != RangeType.CUSTOM)
      return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      width: widget.width,
      height: widget.height,
      child: Row(
        children: [
          if(_isWorkableRangeType()) IconButton(
            icon: Icon(AntDesign.left),
            onPressed: () => _onArrowTap(true),
          ),
          Expanded(
            child: GestureDetector(
              onTap: _selectRange,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  _getTitle(),
                  style: TextStyle(
                    fontSize: widget.height*0.8
                  ),
                ),
              ),
            ),
          ),
          if(_isWorkableRangeType()) IconButton(
            icon: Icon(AntDesign.right),
            onPressed: () => _onArrowTap(false),
          ),
        ],
      ),
    );
  }

  Future<List> _showRangeSelectionDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter by date"),
        content: Container(
          width: MediaQuery.of(context).size.width*0.8,
          height: MediaQuery.of(context).size.height*0.8,
          child: ListView(
            children: [
              ListTile(
                title: Text("Today"),
                onTap: () => Navigator.pop(context, DateTimeUtils.getDayRange(null)),
              ),
              ListTile(
                title: Text("Last 7 days"),
                onTap: () => Navigator.pop(context, DateTimeUtils.getLast7DaysRange()),
              ),
              ListTile(
                title: Text("This Month"),
                onTap: () => Navigator.pop(context, DateTimeUtils.getThisMonthRange()),
              ),
              ListTile(
                title: Text("This Year"),
                onTap: () => Navigator.pop(context, DateTimeUtils.getThisYearRange()),
              ),
              ListTile(
                title: Text("Particular Day"),
                onTap: () async {
                  DateTime date = await MyDialogs.showDatePickerDialog(context);
                  Navigator.pop(context, date != null ? DateTimeUtils.getDayRange(date) : null);
                },
              ),
              ListTile(
                title: Text("Custom Range"),
                onTap: () async {
                  DateTime start = await MyDialogs.showDatePickerDialog(context);
                  DateTime end = await MyDialogs.showDatePickerDialog(context);
                  if(start != null) start = DateTimeUtils.getMinDayTime(start);
                  if(end != null) end = DateTimeUtils.getMaxDayTime(end);
                  Navigator.pop(context, [start, end, RangeType.CUSTOM]);
                },
              ),
            ],
          ),
        ),
      )
    );
  }
}



enum RangeType{
  MINUTE,
  HOUR,
  DAY,
  WEEK,
  MONTH,
  YEAR,
  CUSTOM
}