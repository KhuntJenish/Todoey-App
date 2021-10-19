import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Tasktile extends StatelessWidget {
  final bool? isChecked;
  final DateTime? time;
  final Function? checkboxCallBack;
  final Function()? onLongPressCallBack;
  final Function()? onTapCallBack;
  final String? taskTitle;
  Tasktile(
      {this.taskTitle,
      this.isChecked,
      this.checkboxCallBack,
      this.onLongPressCallBack,
      this.onTapCallBack,
      this.time});

  // void checkcallback

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTapCallBack,
      onLongPress: onLongPressCallBack,
      title: Text(
        taskTitle!,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
            decoration: isChecked! ? TextDecoration.lineThrough : null),
      ),
      subtitle: Text(
        DateFormat.yMMMd().add_jm().format(time!),
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
      trailing: Checkbox(
          activeColor: Colors.lightBlue,
          value: isChecked,
          onChanged: (val) {
            checkboxCallBack!(val);
          }),
    );
  }
}
