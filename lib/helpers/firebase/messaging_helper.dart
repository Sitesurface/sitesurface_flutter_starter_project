import 'package:firebase_messaging/firebase_messaging.dart';

class MessagingHelper {
  static final _messaging = FirebaseMessaging.instance;

  static void init() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {}

  void onMessageListen() {}
}
