import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final Function checkboxCallback;
  final Function longpressCallback;

  TaskTile({this.isChecked, this.taskTitle,this.checkboxCallback,this.longpressCallback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: longpressCallback,
        title: Text(
          taskTitle,
          style: TextStyle(
              fontSize: 20.0,
              fontFamily: "Poppins",
              decoration: isChecked ? TextDecoration.lineThrough : null),
        ),
        trailing: Checkbox(
          value: isChecked,
          activeColor: Color.fromRGBO(31, 48, 83, 1.0),
          onChanged: checkboxCallback,
        )
    );
  }
}
