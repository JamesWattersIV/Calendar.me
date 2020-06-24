import 'package:flutter/material.dart';
import 'package:calendarapp/constants.dart';
import 'package:provider/provider.dart';
import 'package:calendarapp/models/task_data.dart';
import 'package:calendarapp/models/Task.dart';

String newTaskTitle;

class AddBottomSheet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          color:Color(0xff757575),
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    'Add A Daily To-Do',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(31, 48, 83, 1.0),
                    ),
                  ),
                ),
                TextField(
                  autofocus: true,
                  textAlign: TextAlign.center,
                  style:  kInputTextStyle,
                  onChanged: (newText) {
                    newTaskTitle = newText;
                  }
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:15.0),
                  child: FlatButton(
                    padding: EdgeInsets.all(10.0),
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),),
                    child: Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    color: Color.fromRGBO(31, 48, 83, 1.0),
                    onPressed: () {
                        Provider.of<TaskData>(context, listen: false).addTask(newTaskTitle);
                        Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

  }

}