import 'package:flutter/material.dart';
import 'package:time_tracker/models/activity.dart';
import 'package:time_tracker/providers/action_provider.dart';
import 'package:time_tracker/providers/activity_provider.dart';
import 'package:time_tracker/utils/DateTimeUtils.dart';
import 'package:time_tracker/widgets/my_date_range_picker.dart';

class Stats extends StatefulWidget {
  const Stats({Key key}) : super(key: key);

  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {

  List<Activity> parentList;
  DateTime _from, _to;
  RangeType _rangeType;

  @override
  void initState() {
    parentList = [];
    super.initState();
  }

  void _backToParent(){
    if(parentList.isNotEmpty){
      setState(() {
        parentList.removeLast();
      });
    }
  }

  void _goToActivity(Activity activity){
    Activity copied = Activity.copy(activity);
    setState(() {
      parentList.add(copied);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: parentList.isNotEmpty ?
        AppBar(
          title: Text(parentList.last.name),
          leading: BackButton(onPressed: _backToParent,),
        ) : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyDateRange(
              width: MediaQuery.of(context).size.width,
              height: 24,
              from: _from,
              to: _to,
              rangeType: _rangeType,
              onDateChanged: (DateTime from, DateTime to, RangeType rangeType){
                setState(() {
                  _from = from;
                  _to = to;
                  _rangeType = rangeType;
                });
              },
            ),
            getStatList()
          ],
        ),
      ),
    );
  }

  Widget getStatList() => FutureBuilder(
    future: activityProvider.getAllActivity(filterParentWise: true, parentId: parentList.isNotEmpty ? parentList.last.id: null),
    builder: (BuildContext context, AsyncSnapshot snapshot){
      if(snapshot.hasData){
        List<Activity> activityList = snapshot.data;

        if(activityList == null || activityList.isEmpty){
          return Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height*0.75,
            child: Text(
              "No Stat to show",
              style: TextStyle(fontSize: 24),
            ),
          );
        }

        return Column(
          children: activityList.map((activity){
            return InkWell(
              onTap: () => _goToActivity(activity),
              child: Card(
                child: Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(activity.name, style: TextStyle(fontSize: 18),),
                      ),
                      Expanded(child: Container(),),
                      _getTimeValue(activity.id),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );
      }
      return Center(child: CircularProgressIndicator(),);
    },
  );
  
  Widget _getTimeValue(int id) => FutureBuilder(
    future: actionProvider.getActivityTotalTime(id, DateTimeUtils.toSecondsEpoch(_from), DateTimeUtils.toSecondsEpoch(_to)),
    builder: (BuildContext context, AsyncSnapshot snapshot){
      if(snapshot.hasData){
        int data = snapshot.data;
        return Text(
          DateTimeUtils.format(data),
          style: TextStyle(
            fontSize: 24
          ),
        );
      }
      return CircularProgressIndicator();
    },
  );
}
