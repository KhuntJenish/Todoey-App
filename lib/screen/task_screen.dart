import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/model/task_data.dart';
import 'package:todoapp/screen/add_task_screen.dart';
import 'package:todoapp/widgets/task_list.dart';

class TaskScreen extends StatefulWidget {
  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TaskData>(context, listen: false).getDataFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      floatingActionButton: AddTaskScreen(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 60, left: 30, bottom: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  child: Icon(
                    Icons.list,
                    size: 30,
                    color: Colors.lightBlue,
                  ),
                  radius: 30,
                  backgroundColor: Colors.white,
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    print(DateFormat.yMMMd().add_jm().format(DateTime.now()));
                    print(DateFormat('yMMdhm').format(DateTime.now()));
                  },
                  child: Text(
                    "Todoey",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  "${Provider.of<TaskData>(context).taskCounter} Tasks",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: TaskList(),
            ),
          )
        ],
      ),
    );
  }
}
