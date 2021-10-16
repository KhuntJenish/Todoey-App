import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
              checkboxCallBack: (val) {
                taskData.checkbox(task, val);
              },
              onLongPressCallBack: () {
                taskData.deleteTask(task);
              },
              onTapCallBack: () {
                String? updatetask;
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Update Record"),
                        content: TextFormField(
                          autofocus: true,
                          initialValue: task.name,
                          onChanged: (val) {
                            updatetask = val;
                          },
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              taskData.updateTask(task.id!, updatetask!, index);
                              Navigator.pop(context);
                            },
                            child: Text("update"),
                          ),
                        ],
                      );
                    });
                // taskData.updateTask(task);
              },
            );
          },
          itemCount: taskData.taskCounter,
        );
      },
    );
  }
}
