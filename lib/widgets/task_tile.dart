import 'package:flutter/material.dart';

class Tasktile extends StatefulWidget {
  @override
  State<Tasktile> createState() => _TasktileState();
}

class _TasktileState extends State<Tasktile> {
  bool isChecked = false;

  // void checkcallback

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "This is list.",
        style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: TaskCheckbox(
        isChecked,
        (bool checkboxState) {
          setState(() {
            isChecked = checkboxState;
            // print(isChecked);
          });
        },
      ),
    );
  }
}

class TaskCheckbox extends StatelessWidget {
  final bool checkboxState;
  final Function togglecheckboxState;
  TaskCheckbox(this.checkboxState, this.togglecheckboxState);
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Colors.lightBlue,
      value: checkboxState,
      onChanged: (value) {
        togglecheckboxState(value);
      },
    );
  }
}
