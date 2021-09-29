import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:todoapp/model/task.dart';s
import 'package:todoapp/model/task_data.dart';
import 'package:todoapp/widgets/task_tile.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.tasks[index];
            return Tasktile(
              taskTitle: task.name,
              isChecked: task.isDone,
              checkboxCallBack: () {
                // setState(() {
                //   // widget.tasks[index].toggalDone();
                // });
                taskData.updateTask(task);
              },
              onLongPressCallBack: () {
                print('hello');
                taskData.deleteTask(task);
              },
            );
          },
          itemCount: taskData.taskCounter,
        );
      },
    );
  }
}
