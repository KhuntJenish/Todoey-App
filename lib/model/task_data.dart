import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/db/database_provider.dart';
import 'package:todoapp/model/task.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../main.dart';

class TaskData extends ChangeNotifier {
  final List<Task> tasks = [];

  int get taskCounter => tasks.length;

  Future<void> addTask(String newTitle, String time) async {
    final task = Task(name: newTitle, tTime: time);
    DatabaseProvider.db.insert(task).then((newTask) {
      tasks.add(newTask);
      notifyListeners();
    });
    await showNotification(time);
  }

  Future<void> getDataFromDatabase() async {
    tasks.clear();
    var a = await DatabaseProvider.db.getRecord();
    tasks.addAll(a);
    notifyListeners();
  }

  void checkbox(Task task, bool newcheckval) {
    DatabaseProvider.db.updatecheckbox(task.id!, newcheckval);
    task.toggalDone();
    notifyListeners();
  }

  Future<void> updateTask(
      int id, String newTname, int index, String date) async {
    DatabaseProvider.db.updatetname(id, newTname, date).then((value) {
      updatelist(newTname, index, date);
      notifyListeners();
    });
    await showNotification(date);
  }

  void updatelist(String newtname, int index, String date) {
    tasks[index].name = newtname;
    tasks[index].tTime = date;
  }

  void deleteTask(Task task) {
    DatabaseProvider.db.delete(task.id!).then((value) {
      tasks.remove(task);
      notifyListeners();
    });
  }

  TimeOfDay selectedTime = TimeOfDay.now();
  int? hour, minute, second;
  TimeOfDay? pickedtime;
  DateTime? pickeddate;
  DateTime current = DateTime.now();
  String? newdate;

  // void gettime() {
  //   timeController = TextEditingController(
  //       text: DateFormat.yMMMd().add_jm().format(DateTime.now()));
  //   // DateFormat('y')

  //   notifyListeners();
  // }

  String setTime() {
    return newdate == null ? current.toString() : newdate.toString();
  }

  Future<Null> selectDate(BuildContext context) async {
    DateTime? selectedDate = DateTime.now();
    pickeddate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2021),
        lastDate: DateTime(2030));
  }

  Future<String> selectTime({required BuildContext context}) async {
    pickedtime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedtime != null) {
      selectedTime = pickedtime!;
      hour = pickedtime!.hour;
      minute = pickedtime!.minute;
      newdate = DateTime(pickeddate!.year, pickeddate!.month, pickeddate!.day,
              pickedtime!.hour, pickedtime!.minute)
          .toString();
      notifyListeners();

      // print(ttime.text);
      return DateTime.parse(newdate!).toString();
    }
    return DateTime.now().toString();
  }

  Future<void> showNotification(String time) async {
    print('notification done ' + time);
    tz.initializeTimeZones();
    const MethodChannel platform =
        MethodChannel('dexterx.dev/flutter_local_notifications_example');
    final String? alarmUri = await platform.invokeMethod<String>('getAlarmUri');
    final UriAndroidNotificationSound uriSound =
        UriAndroidNotificationSound(alarmUri!);

    flutterLocalNotificationsPlugin.zonedSchedule(
        int.parse(DateFormat('MMdHm').format(DateTime.parse(time))),
        'scheduled title',
        'scheduled body',
        tz.TZDateTime.parse(tz.local, time),
        NotificationDetails(
            android: AndroidNotificationDetails(
                'full screen channel id', 'full screen channel name',
                channelDescription: 'full screen channel description',
                sound: uriSound,
                // priority: Priority.high,
                // importance: Importance.high,
                fullScreenIntent: true)),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  // Future<void> zonedScheduleNotification(String time) async {
  //   print('notification done ' + time);
  //   tz.initializeTimeZones();
  //   const MethodChannel platform =
  //       MethodChannel('dexterx.dev/flutter_local_notifications_example');
  //   final String? alarmUri = await platform.invokeMethod<String>('getAlarmUri');
  //   final UriAndroidNotificationSound uriSound =
  //       UriAndroidNotificationSound(alarmUri!);
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //       0,
  //       'scheduled title',
  //       'scheduled body',
  //       // tz.TZDateTime.parse(tz.local, time),
  //       tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
  //       NotificationDetails(
  //         android: AndroidNotificationDetails(
  //           'uri channel id',
  //           'uri channel name',
  //           channelDescription: 'uri channel description',
  //           sound: uriSound,
  //           priority: Priority.high,
  //           importance: Importance.high,
  //           fullScreenIntent: true,
  //           styleInformation: const DefaultStyleInformation(true, true),
  //         ),
  //       ),
  //       androidAllowWhileIdle: true,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime);
  // }
}
