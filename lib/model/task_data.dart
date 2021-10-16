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
  TextEditingController timeController = TextEditingController();
  final List<Task> tasks = [
    // Task(name: 'buy Daimond'),
    // Task(name: 'buy Mik'),
    // Task(name: 'buy Glosary'),
  ];

  // List<Task> get gettasks => tasks;
  // UnmodifiableListView

  int get taskCounter => tasks.length;

  void addTask(String newTitle) {
    final task = Task(name: newTitle);
    DatabaseProvider.db.insert(task).then((newTask) {
      tasks.add(newTask);
      notifyListeners();
    });
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

  void updateTask(int id, String newTname, int index) {
    DatabaseProvider.db.updatetname(id, newTname).then((value) {
      updatelist(newTname, index);
      notifyListeners();
    });
    // getDataFromDatabase();
  }

  void updatelist(String newtname, int index) {
    tasks[index].name = newtname;
  }

  void deleteTask(Task task) {
    DatabaseProvider.db.delete(task.id!).then((value) {
      tasks.remove(task);
      notifyListeners();
    });
  }

  TimeOfDay selectedTime = TimeOfDay.now();
  int? hour, minute, second;
  String? dateTime;
  TimeOfDay? picked;
  DateTime current = DateTime.now();
  DateTime? newdate;

  Future<Null> selectTime(BuildContext context) async {
    picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      selectedTime = picked!;
      hour = picked!.hour;
      minute = picked!.minute;
      newdate = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, hour!, minute!);
      second = current.difference(newdate!).inSeconds;
      timeController.text = '${hour}:${minute}';
    }
  }

  // Future<void> showNotification() async {
  //   tz.initializeTimeZones();
  //   const MethodChannel platform =
  //       MethodChannel('dexterx.dev/flutter_local_notifications_example');
  //   final String? alarmUri = await platform.invokeMethod<String>('getAlarmUri');
  //   final UriAndroidNotificationSound uriSound =
  //       UriAndroidNotificationSound(alarmUri!);

  //   flutterLocalNotificationsPlugin.zonedSchedule(
  //       0,
  //       'scheduled title',
  //       'scheduled body',
  //       tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
  //       NotificationDetails(
  //           android: AndroidNotificationDetails(
  //               'full screen channel id', 'full screen channel name',
  //               channelDescription: 'full screen channel description',
  //               sound: uriSound,
  //               priority: Priority.high,
  //               importance: Importance.high,
  //               fullScreenIntent: true)),
  //       androidAllowWhileIdle: true,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime);
  // }

  Future<void> zonedScheduleNotification() async {
    tz.initializeTimeZones();
    const MethodChannel platform =
        MethodChannel('dexterx.dev/flutter_local_notifications_example');
    final String? alarmUri = await platform.invokeMethod<String>('getAlarmUri');
    final UriAndroidNotificationSound uriSound =
        UriAndroidNotificationSound(alarmUri!);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'scheduled title',
        'scheduled body',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 3)),
        NotificationDetails(
          android: AndroidNotificationDetails(
            'uri channel id',
            'uri channel name',
            channelDescription: 'uri channel description',
            sound: uriSound,
            priority: Priority.high,
            importance: Importance.high,
            fullScreenIntent: true,
            styleInformation: const DefaultStyleInformation(true, true),
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
