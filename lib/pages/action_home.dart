import 'package:flutter/material.dart';

class ActionHome extends StatefulWidget {
  const ActionHome({Key key}) : super(key: key);

  @override
  _ActionHomeState createState() => _ActionHomeState();
}

class _ActionHomeState extends State<ActionHome> {

  double _startButtonRadius;

  @override
  void initState() {
    _startButtonRadius = 150;
    super.initState();
  }

  void _chooseActivity(){

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: _startButtonRadius,
              child: CircleAvatar(
                backgroundColor: Colors.green,
                radius: _startButtonRadius - 5,
                child: Text(
                  'START',
                  style: TextStyle(
                      fontSize: 72,
                      color: Colors.white
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: FloatingActionButton.extended(
              onPressed: _chooseActivity,
              label: Text('OFFICE', style: TextStyle(fontSize: 32),),
            ),
          ),
          Expanded(
            child: Container(),
          )
        ],
      ),
    );
  }
}
