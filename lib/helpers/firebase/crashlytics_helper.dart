import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CrashlyticsHelper {
  static final _crashlytics = FirebaseCrashlytics.instance;

  static recordError(error, stacktrace, {String? message}) async {
    _crashlytics.recordError(error, stacktrace, reason: message);
  }

  static dynamic recordFlutterError = _crashlytics.recordFlutterError;
}
