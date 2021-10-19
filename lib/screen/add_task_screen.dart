import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/model/task_data.dart';

class AddTaskScreen extends StatelessWidget {
  // AddTaskScreen(this.time);
  // TextEditingController time;
  late TextEditingController timeController;
  late String dateTime = DateTime.now().toString();

  String? newTaskTitle;
  String? tTime;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.lightBlue,
      onPressed: () async {
        await showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            timeController = TextEditingController(
                text: DateFormat.yMMMd().add_jm().format(DateTime.now()));
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
                      // controller: name,
                      autofocus: true,
                      textAlign: TextAlign.center,
                      textInputAction: TextInputAction.next,
                      onChanged: (newval) {
                        newTaskTitle = newval;
                        print(newTaskTitle);
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
                              margin: EdgeInsets.only(
                                  right: 70, left: 10, bottom: 10),
                              child: TextField(
                                controller: timeController,
                                style: TextStyle(fontSize: 15),
                                onTap: () async {
                                  await Provider.of<TaskData>(context,
                                          listen: false)
                                      .selectDate(context);
                                  dateTime = await Provider.of<TaskData>(
                                          context,
                                          listen: false)
                                      .selectTime(context: context);
                                  // print(timeController.text);
                                  timeController.text = DateFormat.yMMMd()
                                      .add_jm()
                                      .format(DateTime.parse(dateTime));
                                },
                                readOnly: true,
                                // decoration: InputDecoration(
                                //     // suffixIcon: Icon(
                                //     //   Icons.date_range,
                                //     //   // size: 20,
                                //     // ),
                                //     ),
                                textInputAction: TextInputAction.done,
                                // onFieldSubmitted: (_) {
                                //   Navigator.pop(context);
                                // },
                                // textAlign: TextAlign.center,
                                // onChanged: (d) {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.lightBlue),
                      ),
                      child: Text(
                        "Add",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        // tTime = Provider.of<TaskData>(context, listen: false)
                        //     .setTime();
                        print(newTaskTitle);
                        print(tTime);
                        Provider.of<TaskData>(context, listen: false)
                            .addTask(newTaskTitle!, dateTime);
                        // Provider.of<TaskData>(context, listen: false)
                        //     .getDataFromDatabase();
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Icon(Icons.add),
    );
  }
}
