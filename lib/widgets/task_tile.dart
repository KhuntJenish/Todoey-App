import 'package:flutter/material.dart';

class Tasktile extends StatelessWidget {
  final bool? isChecked;
  final Function? checkboxCallBack;
  final Function()? onLongPressCallBack;
  final Function()? onTapCallBack;
  final String? taskTitle;
  Tasktile({
    this.taskTitle,
    this.isChecked,
    this.checkboxCallBack,
    this.onLongPressCallBack,
    this.onTapCallBack,
  });

  // void checkcallback

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTapCallBack,
      onLongPress: onLongPressCallBack,
      title: Text(
        taskTitle!,
        style: TextStyle(
            decoration: isChecked! ? TextDecoration.lineThrough : null),
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
