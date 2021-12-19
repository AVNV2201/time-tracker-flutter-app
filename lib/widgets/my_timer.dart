import 'dart:async';

import 'package:flutter/material.dart';
import 'package:time_tracker/utils/DateTimeUtils.dart';

class MyTimer extends StatefulWidget {

  final Duration duration;
  final double fontSize;

  const MyTimer({Key key, this.duration, this.fontSize: 18}) : super(key: key);

  @override
  _MyTimerState createState() => _MyTimerState();
}

class _MyTimerState extends State<MyTimer> {

  int _seconds;
  Timer _timer;

  @override
  void initState() {
    _seconds = widget.duration.inSeconds;
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer){
        setState(() {
          _seconds++;
        });
      }
    );
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      DateTimeUtils.format(_seconds),
      style: TextStyle(
        fontSize: widget.fontSize,
        color: Colors.white
      ),
    );
  }
}


