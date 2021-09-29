import 'package:flutter/foundation.dart';
import 'package:todoapp/model/task.dart';

class TaskData extends ChangeNotifier {
  final List<Task> tasks = [
    Task(name: 'buy Daimond'),
    Task(name: 'buy Mik'),
    Task(name: 'buy Glosary'),
  ];

  // UnmodifiableListView<Task> get gettasks => tasks;
  // UnmodifiableListView

  int get taskCounter {
    return tasks.length;
  }

  void addTask(String newTitle) {
    final task = Task(name: newTitle);
    tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggalDone();
    notifyListeners();
  }

  void deleteTask(Task task) {
    tasks.remove(task);
    notifyListeners();
  }
}
