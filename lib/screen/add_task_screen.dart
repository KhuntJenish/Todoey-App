import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/model/task_data.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String? newTaskTitle;
    return Container(
      height: MediaQuery.of(context).size.height * 0.64,
      color: Color(0xff757575),
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add Task",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: Colors.lightBlue,
              ),
            ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              textInputAction: TextInputAction.next,
              onChanged: (newval) {
                newTaskTitle = newval;
              },
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text('Task Time : '),
                  Expanded(
                    child: Container(
                      height: 40,
                      margin: EdgeInsets.only(right: 170, left: 10, bottom: 10),
                      child: TextFormField(
                        onTap: () {
                          Provider.of<TaskData>(context, listen: false)
                              .selectTime(context);
                        },
                        readOnly: true,
                        controller:
                            Provider.of<TaskData>(context).timeController,
                        // initialValue: Provider.of<TaskData>(context).time,
                        decoration: InputDecoration(),
                        // autofocus: true,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (a) {
                          Navigator.pop(context);
                        },
                        textAlign: TextAlign.center,
                        onChanged: (newval) {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.lightBlue),
              ),
              child: Text(
                "Add",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                Provider.of<TaskData>(context, listen: false)
                    .addTask(newTaskTitle!);
                // Provider.of<TaskData>(context, listen: false)
                //     .getDataFromDatabase();
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
