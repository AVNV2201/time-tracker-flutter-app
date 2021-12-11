import 'package:flutter/material.dart';
import 'package:time_tracker/utils/constants.dart';

class MyDialogs{

  // GENERIC DIALOGS

  // to show informative dialogs
  static Future<void> showInfoDialog(BuildContext context, Widget icon, String title, String message) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Row(
            children: [
              if(icon != null) Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: icon,
              ),
              Text(title),
            ],
          ),
          content: Text(message,),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            )
          ],
        )
    );
  }

  // yes / no dialog box
  static Future<bool> showConfirmationDialog(BuildContext context,{
    @required Icon icon,
    @required String title,
    @required String message,
  }) async {
    bool result = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              icon,
              SizedBox(width: 20,),
              Text(title),
            ],
          ),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('No'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Yes'),
            )
          ],
        )
    );

    return result ?? false;
  }

  // SPECIFIC DIALOGS

  static Future<void> showErrorDialog(BuildContext context, {String message = ErrorMessage.unknownError}) async {
    await showInfoDialog(context, Icon(Icons.error), 'Error', message);
  }

}