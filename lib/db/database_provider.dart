import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/model/task.dart';
import 'package:todoapp/model/task_data.dart';

class DatabaseProvider {
  static const String TABLE_NAME = "t_table";
  static const String COLUMN_ID = "tid";
  static const String COLUMN_TNAME = "tname";
  static const String COLUMN_TCHECK = "tcheck";
  static const String COLUMN_TTIME = "ttime";

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database? _database;

  Future<Database> get database async {
    print("Database getter called.");

    if (_database != null) {
      // print()
      return _database!;
    }

    _database = await createDatabase();

    return _database!;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(join(dbPath, "foodDB.db"), version: 1,
        onCreate: (Database database, int version) async {
      print("Creating a table.");

      await database.execute(
        "CREATE TABLE $TABLE_NAME ("
        "$COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$COLUMN_TNAME TEXT ,"
        "$COLUMN_TCHECK INTEGER "
        // "$COLUMN_TTIME DATETIME NOT NULL"
        ")",
      );
    });
  }

  Future<void> getRecord(BuildContext context) async {
    print('getRecord');
    final db = await database;

    var tasks = await db.query(TABLE_NAME);
    print(tasks);

    List<Task> taskList = [];
    tasks.forEach((element) {
      Task task = Task.fromMap(element);
      taskList.add(task);

      // print(Provider.of<TaskData>(context, listen: false).tasks[i]);
      // i++;
    });
    Provider.of<TaskData>(context, listen: false).tasks.clear();
    Provider.of<TaskData>(context, listen: false).tasks.addAll(taskList);

    // return taskList;
  }

  Future<Task> insert(Task task) async {
    final db = await database;
    task.id = await db.insert(TABLE_NAME, task.toMap());
    print(task.id);
    return task;
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete(
      TABLE_NAME,
      where: "$COLUMN_ID = ?",
      whereArgs: [id],
    );
  }

  Future<int> update(Task task) async {
    final db = await database;
    return await db.update(
      TABLE_NAME,
      task.toMap(),
      where: "$COLUMN_ID = ?",
      whereArgs: [task.id],
    );
  }
}
