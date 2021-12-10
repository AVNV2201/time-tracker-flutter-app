import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {

  final padding;
  final fontSize;
  final bool center ;
  final Color color;

  const AppLogo({Key key, this.color = Colors.white, this.padding, this.fontSize, this.center = true }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: center ? Alignment.center: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(vertical: padding),
      child: Text(
        'Time Tracker',
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
