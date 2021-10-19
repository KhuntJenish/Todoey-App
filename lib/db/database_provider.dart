import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/model/task.dart';

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
    print("Creating a table.");

    String dbPath = await getDatabasesPath();
    print(dbPath);
    return await openDatabase(join(dbPath, "foodDB.db"), version: 1,
        onCreate: (Database database, int version) async {
      await database.execute(
        "CREATE TABLE $TABLE_NAME ("
        "$COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$COLUMN_TNAME TEXT,"
        "$COLUMN_TCHECK INTEGER,"
        "$COLUMN_TTIME TEXT"
        ")",
      );
    });
  }

  Future<List<Task>> getRecord() async {
    // print('getRecord');
    final db = await database;

    var task = await db.query(TABLE_NAME);
    print(task);

    List<Task> taskList = [];
    task.forEach((element) {
      Task task = Task.fromMap(element);
      taskList.add(task);
    });

    // Provider.of<TaskData>(context, listen: false).gettasks.clear();
    // Provider.of<TaskData>(context, listen: false).gettasks.addAll(taskList);

    return taskList;
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

  clear() async {
    final db = await database;
    var query = 'delete from ${TABLE_NAME}';
    await db.rawDelete(query);
  }

  Future updatetname(int id, String newname, String date) async {
    final db = await database;
    await db.update(
      TABLE_NAME,
      // task.toMap(),
      {COLUMN_TNAME: newname, COLUMN_TTIME: date},
      where: "$COLUMN_ID = ?",
      whereArgs: [id],
    );
  }

  Future updatecheckbox(int id, bool newcheck) async {
    final db = await database;
    await db.update(
      TABLE_NAME,
      // task.toMap(),
      {COLUMN_TCHECK: newcheck ? 1 : 0},
      where: "$COLUMN_ID = ?",
      whereArgs: [id],
    );
  }
}
