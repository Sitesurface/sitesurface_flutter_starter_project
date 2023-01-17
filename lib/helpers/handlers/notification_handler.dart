import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sitesurface_flutter_starter_project/helpers/firebase/dynamic_link_helper.dart';

class NotificationHandler extends StatefulWidget {
  final Widget child;
  const NotificationHandler({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<NotificationHandler> createState() => _NotificationHandlerState();
}

class _NotificationHandlerState extends State<NotificationHandler> {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _localMessaging = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    initialiseFirebase();
    initialiseLocalNotifications();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  Future<void> initialiseFirebase() async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    _firebaseMessaging.requestPermission();
    FirebaseMessaging.onMessage.listen((event) {
      var notification = event.notification;
      _localMessaging.show(
          notification.hashCode,
          notification?.title ?? '',
          notification?.body ?? '',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              "high_importance_channel",
              "High Importance Notifications",
              icon: '@mipmap/launcher_icon',
            ),
          ),
          payload: jsonEncode(event.data));
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      ActionHandler.handle(event.data);
    });
    _firebaseMessaging.getInitialMessage().then((event) {
      if (event == null) return;
      ActionHandler.handle(event.data);
    });
  }

  Future<void> initialiseLocalNotifications() async {
    await _localMessaging
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
            onDidReceiveLocalNotification: (
              int id,
              String? title,
              String? body,
              String? payload,
            ) async {
              debugPrint(payload);
            });

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await _localMessaging.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (notificationResponse) async {
      if (notificationResponse.payload == null) return;
      var message = jsonDecode(notificationResponse.payload!);
      ActionHandler.handle(message);
    });
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {}
