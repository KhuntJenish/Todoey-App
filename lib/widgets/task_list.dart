import 'package:flutter/material.dart';
import 'package:todoapp/model/task.dart';
import 'package:todoapp/widgets/task_tile.dart';

class TaskList extends StatefulWidget {
  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> tasks = [
    Task(name: 'buy Daimond'),
    Task(name: 'buy Mik'),
    Task(name: 'buy Glosary'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Tasktile(
          taskTitle: tasks[index].name,
          isChecked: tasks[index].isDone,
          checkboxCallBack: (chekboxState) {
            setState(() {
              tasks[index].toggalDone();
            });
          },
        );
      },
      itemCount: tasks.length,
    );
  }
}
