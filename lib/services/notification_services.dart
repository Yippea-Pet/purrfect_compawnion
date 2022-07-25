import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:purrfect_compawnion/pages/features/pethouse.dart';
import 'package:purrfect_compawnion/pages/features/todo_1.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../models/task.dart';

class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initializeNotification() async {
    _configureLocalTimezone();
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestSoundPermission: false,
            requestBadgePermission: false,
            requestAlertPermission: false,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("appicon");

    final InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  displayNotification({required String title, required String body}) async {
    print("doing test");
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high, icon: 'appicon');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'You change your theme',
      'You changed your theme back !',
      platformChannelSpecifics,
      payload: 'It could be anything you pass',
    );
  }

  scheduledNotification(String id, Task task) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id.hashCode,
        task.title,
        task.note,
        _convertTime(task),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                importance: Importance.max,
                priority: Priority.high,
                icon: 'appicon')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: "${task.title}|${task.note}",
    );
  }

  editScheduledNotification(String id, Task? task) async {
    await flutterLocalNotificationsPlugin.cancel(id.hashCode);
    if (task != null) {
      scheduledNotification(id, task);
    }
  }

  scheduledHungryNotification(int hour) async {
    await flutterLocalNotificationsPlugin.cancel(0);
    if (hour <= 0) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
          0,
          "Warning!",
          "Your pet is starving!",
          tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
          const NotificationDetails(
              android: AndroidNotificationDetails(
                  'your channel id', 'your channel name',
                  importance: Importance.max,
                  priority: Priority.high,
                  icon: 'appicon')),
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
          androidAllowWhileIdle: true,
          payload: "Feed your pet!",
      );
    } else {
      await flutterLocalNotificationsPlugin.zonedSchedule(
          0,
          "Warning!",
          "Your pet is starving!",
          tz.TZDateTime.now(tz.local).add(Duration(hours: hour)),
          const NotificationDetails(
              android: AndroidNotificationDetails(
                  'your channel id', 'your channel name',
                  importance: Importance.max,
                  priority: Priority.high,
                  icon: 'appicon')),
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
          androidAllowWhileIdle: true,
          payload: "Feed your pet!",
      );
    }
  }

  tz.TZDateTime _convertTime(Task task) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    print(task.title);
    print(task.getRemindTime());
    tz.TZDateTime test = tz.TZDateTime.from(task.getRemindTime(), tz.local);
    if (test.isBefore(now)) {
      test = now.add(Duration(seconds: 5));
    }

    return test;
  }

  periodicNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
        'repeating channel id', 'repeating channel name',
        channelDescription: 'repeating description');
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.periodicallyShow(0, 'repeating title',
        'repeating body', RepeatInterval.everyMinute, platformChannelSpecifics,
        androidAllowWhileIdle: true);
  }

  _configureLocalTimezone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    } else {
      print("Notification Done");
    }
    if (payload=="Feed your pet!") {
      // TODO: Hunger level drops below xx level notification
      Get.to(() => PetHouse());
    } else {
      Get.to(() => ToDo());
      // Get.to(() => NotifiedPage(label: payload ?? ""));
    }
  }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    /*showDialog(
      //context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondScreen(payload),
                ),
              );
            },
          )
        ],
      ),
    );*/
    Get.dialog(Text("Welcome to flutter"));
  }
}
