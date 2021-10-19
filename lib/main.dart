import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todoapp/db/database_provider.dart';
import 'package:todoapp/model/task_data.dart';
import 'package:todoapp/screen/task_screen.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // DatabaseProvider.db.clear();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('logo');
  final IOSInitializationSettings initializationSettingIOS =
      IOSInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
          onDidReceiveLocalNotification: (
            int id,
            String? title,
            String? body,
            String? payload,
          ) async {});
  final InitializationSettings initializationSetting = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSetting,
      onSelectNotification: (String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
  });

  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TaskScreen(),
      ),
    );
  }
}
