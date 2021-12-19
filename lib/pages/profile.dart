import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/providers/action_provider.dart';
import 'package:time_tracker/providers/activity_provider.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  void _resetActions(){
    actionProvider.deleteAllAction();
  }

  void _resetAllData() async {
    await actionProvider.deleteAllAction();
    await activityProvider.deleteAllActivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Container(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(CupertinoIcons.trash),
              title: Text("Reset All Action Data"),
              onTap: _resetActions,
            ),
            ListTile(
              leading: Icon(CupertinoIcons.trash),
              title: Text("Reset App"),
              onTap: _resetAllData,
            )
          ],
        ),
      ),
    );
  }
}
