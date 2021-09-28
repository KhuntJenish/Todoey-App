import 'package:flutter/material.dart';

class Tasktile extends StatelessWidget {
  final bool? isChecked;
  final Function? checkboxCallBack;
  final String? taskTitle;
  Tasktile({this.taskTitle, this.isChecked, this.checkboxCallBack});

  // void checkcallback

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        taskTitle!,
        style: TextStyle(
            decoration: isChecked! ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
          activeColor: Colors.lightBlue,
          value: isChecked,
          onChanged: (newval) {
            checkboxCallBack!(newval);
          }),
    );
  }
}
