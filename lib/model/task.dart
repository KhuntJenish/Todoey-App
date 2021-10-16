import 'package:todoapp/db/database_provider.dart';

class Task {
  int? id;
  String? name;
  bool? isDone;
  Task({this.name, this.isDone = false});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_TNAME: name,
      DatabaseProvider.COLUMN_TCHECK: isDone == true ? 1 : 0
    };
    if (id != null) {
      map[DatabaseProvider.COLUMN_ID] = id;
    }
    return map;
  }

  Task.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.COLUMN_ID];
    name = map[DatabaseProvider.COLUMN_TNAME];
    isDone = map[DatabaseProvider.COLUMN_TCHECK] == 1;
  }

  void toggalDone() {
    bool a = isDone!;
    isDone = !a;
  }
}
