import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationUtil {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _notifications.initialize(initializationSettings);
  }

  static Future _notificationDetails(String cId,String cName) async{
    return NotificationDetails(
      android: AndroidNotificationDetails(cId, cName)
    );
  }
  static Future showNotification({
    int id = 0,
    String title = "",
    String body = "",
    String payload = "",
    String cId="1",
    String cName="Alerts",
  }) async {
    return _notifications.show(id, title, body, await _notificationDetails(cId,cName));
  }
}
