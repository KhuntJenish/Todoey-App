import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/main.dart';
import 'package:todoapp/model/task_data.dart';
import 'package:todoapp/widgets/task_tile.dart';

class TaskList extends StatelessWidget {
  late String datetime = DateTime.now().toString();
  String? updatetask;
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, _) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.tasks[index];
            return Tasktile(
              time: DateTime.parse(taskData.tasks[index].tTime!),
              // time: DateTime.now(),
              taskTitle: task.name,
              isChecked: task.isDone,
              checkboxCallBack: (val) {
                taskData.checkbox(task, val);
                if (task.isDone!) {
                  int id = int.parse(
                      DateFormat('MMdHm').format(DateTime.parse(task.tTime!)));
                  flutterLocalNotificationsPlugin.cancel(id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('notification cancel')),
                  );
                } else {
                  Provider.of<TaskData>(context, listen: false)
                      .showNotification(task.tTime!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('set notification')),
                  );
                }
              },
              onLongPressCallBack: () {
                taskData.deleteTask(task);
              },
              onTapCallBack: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      TextEditingController uTime = TextEditingController(
                        text: DateFormat.yMMMd().add_jm().format(
                              DateTime.parse(task.tTime!),
                            ),
                      );
                      return AlertDialog(
                        title: Text("Update Record"),
                        content: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              autofocus: true,
                              initialValue: task.name,
                              onChanged: (val) {
                                updatetask = val;
                              },
                            ),
                            Row(
                              children: [
                                Text('Task Time : '),
                                Expanded(
                                  child: Container(
                                    height: 40,
                                    margin: EdgeInsets.only(
                                        right: 0, left: 10, bottom: 8),
                                    child: TextField(
                                      style: TextStyle(fontSize: 15),
                                      onTap: () async {
                                        await Provider.of<TaskData>(context,
                                                listen: false)
                                            .selectDate(context);
                                        datetime = await Provider.of<TaskData>(
                                                context,
                                                listen: false)
                                            .selectTime(context: context);
                                        uTime.text = DateFormat.yMMMd()
                                            .add_jm()
                                            .format(DateTime.parse(datetime));
                                      },
                                      readOnly: true,
                                      controller: uTime,
                                      decoration: InputDecoration(),
                                      textInputAction: TextInputAction.done,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              print(datetime);
                              taskData.updateTask(
                                  task.id!, updatetask!, index, datetime);
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
