import 'package:flutter/material.dart';
import 'package:todoapp/widgets/task_tile.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Tasktile(),
        Tasktile(),
        Tasktile(),
        Tasktile(),
        Tasktile(),
        Tasktile(),
      ],
    );
  }
}
