import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/db/database_provider.dart';
import 'package:todoapp/model/task.dart';

class TaskData extends ChangeNotifier {
  // final List<Task> tasks = DatabaseProvider.db.getRecord(context);
  final List<Task> tasks = [
    // Task(name: 'buy Daimond'),
    // Task(name: 'buy Mik'),
    // Task(name: 'buy Glosary'),
  ];

  // UnmodifiableListView<Task> get gettasks => tasks;
  // UnmodifiableListView

  int get taskCounter => tasks.length;

  void addTask(String newTitle) {
    final task = Task(name: newTitle);
    DatabaseProvider.db.insert(task).then(
          (newTask) => tasks.add(newTask),
        );
    notifyListeners();
    // tasks.add(task);
  }

  void updateTask(Task task) {
    task.toggalDone();
    notifyListeners();
  }

  void deleteTask(Task task) {
    DatabaseProvider.db.delete(task.id!).then(
          (value) => tasks.remove(task),
        );
    // tasks.remove(task);
    notifyListeners();
  }
}
