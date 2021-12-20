import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/models/activity.dart';
import 'package:time_tracker/providers/activity_provider.dart';

class ActivityHome extends StatefulWidget {
  const ActivityHome({Key key}) : super(key: key);

  @override
  _ActivityHomeState createState() => _ActivityHomeState();
}

class _ActivityHomeState extends State<ActivityHome> {

  List<Activity> parentList;
  TextEditingController nameController;

  @override
  void initState() {
    parentList = [];
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void _backToParent(){
    if(parentList.isNotEmpty){
      setState(() {
        parentList.removeLast();
      });
    }
  }

  void _addActivity() async{
    String name = await getActivityNameDialog();
    if(name == null || name.isEmpty)
      return;
    Activity activity = Activity.createActivity(name, parentList.isNotEmpty ? parentList.last.id : null);
    await activityProvider.addActivity(activity);
    nameController.text = "";
    setState(() {

    });
  }

  void _deleteActivity(int id){
    activityProvider.deleteActivityById(id);
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
      appBar: parentList.isNotEmpty ? AppBar(
        title: Text(parentList.last.name),
        centerTitle: true,
        leading: BackButton(onPressed: _backToParent,),
      ) : null,
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(CupertinoIcons.plus),
        label: Text("Add Activity"),
        onPressed: _addActivity,
      ),
      body: buildActivityList(),
    );
  }

  Widget buildActivityList() => FutureBuilder(
    future: activityProvider.getAllActivity(
        filterParentWise: true,
        parentId: parentList.isNotEmpty ? parentList.last.id : null
    ),
    builder: (BuildContext context, AsyncSnapshot snapshot){
      if(snapshot.hasData){
        List<Activity> activityList = snapshot.data;

        if(activityList == null || activityList.isEmpty)
          return _getEmptyListScreen();

        return ListView.builder(
          itemCount: activityList.length,
          itemBuilder: (context, index){
            final key = activityList[index].createdAt.toString();
            return Dismissible(
              key: Key(key),
              onDismissed: (direction){
                _deleteActivity(activityList[index].id);
                activityList.removeAt(index);
              },
              background: Container(
                alignment: Alignment.center,
                color: Colors.red,
                child: Text("Deleted")
              ),
              child: ListTile(
                onTap: () => _goToActivity(activityList[index]),
                title: Text(activityList[index].name),
                trailing: Switch(
                  value: activityList[index].active,
                  onChanged: (bool value) async {
                    activityList[index].active = value;
                    Activity updatedActivity = await activityProvider.updateActivity(activityList[index]);
                    setState(() {
                      activityList[index] = updatedActivity;
                    });
                  },
                ),
              ),
            );
          },
        );
      }

      return Center(child: CircularProgressIndicator());
    },
  );

  Widget _getEmptyListScreen() => const Center(
    child: const Text(
      "No Activity Found \n You can create one",
    ),
  );

  void _onSaveActivityName(){
    Navigator.pop(context, nameController.text);
  }

  Future<String> getActivityNameDialog() async => await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: nameController,
          autofocus: true,
          onSubmitted: (value) => _onSaveActivityName,
          decoration: InputDecoration(
              filled: true,
              border: OutlineInputBorder(),
              labelText: 'Activity Name',
              hintText: 'Self Study'
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context, null),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _onSaveActivityName,
            child: Text('Save'),
          )
        ],
      )
  );

}

