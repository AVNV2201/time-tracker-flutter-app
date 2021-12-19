import 'package:flutter/material.dart';
import 'package:time_tracker/models/activity.dart';
import 'package:time_tracker/providers/action_provider.dart';
import 'package:time_tracker/providers/activity_provider.dart';
import 'package:time_tracker/providers/app_data.dart';
import 'package:time_tracker/models/action.dart' as TTAction;
import 'package:time_tracker/widgets/my_timer.dart';

class ActionHome extends StatefulWidget {
  const ActionHome({Key key}) : super(key: key);

  @override
  _ActionHomeState createState() => _ActionHomeState();
}

class _ActionHomeState extends State<ActionHome> {

  double _startButtonRadius;
  List<Activity> activity;
  Activity _selectedActivity;
  bool _actionRunning;

  void _loadLatestActivity() async {
    activity = await activityProvider.getAllActivity(active: true);

    if(appData.actionInProgress != null){
      Activity temp = await activityProvider.getActivity(appData.actionInProgress.activityId);
      setState(() {
        _actionRunning = true;
        _selectedActivity = temp;
      });
    }
    else if(activity != null && activity.isNotEmpty){
      setState(() {
        _selectedActivity = activity.first;
      });
    }
  }

  @override
  void initState() {
    _actionRunning = false;
    _startButtonRadius = 150;
    _loadLatestActivity();
    super.initState();
  }

  void _chooseActivity() async {
    Activity activity = await showActivityListDialog();
    if(activity != null){
      setState(() {
        _selectedActivity = activity;
      });
    }
  }

  void _toggleActionMode() async {
    if(_actionRunning){
      appData.actionInProgress.end = DateTime.now();
      _selectedActivity.updatedAt = DateTime.now();
      actionProvider.addAction(appData.actionInProgress);
      activityProvider.updateActivity(_selectedActivity);
      appData.resetAction();
      setState(() {
        _actionRunning = false;
      });
    }
    else{
      if(_selectedActivity != null){
        appData.actionInProgress = TTAction.Action.createAction(_selectedActivity.id);
        appData.saveAppData();
        setState(() {
          _actionRunning = true;
        });
      }
      else{
        _chooseActivity();
      }
    }
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
            child: GestureDetector(
              onTap: _toggleActionMode,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: _startButtonRadius,
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: _startButtonRadius - 5,
                  child: _actionRunning ?
                      MyTimer(
                        fontSize: _startButtonRadius/2,
                        duration: DateTime.now().difference(appData.actionInProgress.start),
                      ) :
                      Text(
                        'START',
                        style: TextStyle(
                            fontSize: 72,
                            color: Colors.white
                        ),
                      ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: FloatingActionButton.extended(
              onPressed: _chooseActivity,
              label: Text(
                _selectedActivity != null ? _selectedActivity.name : "Choose Activity",
                style: TextStyle(fontSize: 32),
              ),
            ),
          ),
          Expanded(
            child: Container(),
          )
        ],
      ),
    );
  }

  Future<Activity> showActivityListDialog() async {
    if(activity == null || activity.isEmpty){
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Container(
            child: Text(
              "No Activity Found \n Plase Add at least one"
            ),
          ),
          actions: [
            ElevatedButton(
              child: Text("Close"),
              onPressed: () => Navigator.pop(context, null),
            )
          ],
        )
      );
      return null;
    }

    return await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Choose Activity"),
        content: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.8,
          child: ListView.builder(
            itemCount: activity.length,
            itemBuilder: (context, index){
              return ListTile(
                onTap: () => Navigator.pop(context, activity[index]),
                title: Text(
                  activity[index].name
                ),
              );
            },
          ),
        ),
        actions: [
          ElevatedButton(
            child: Text("Close"),
            onPressed: () => Navigator.pop(context, null),
          )
        ],
      )
    );
  }
}
