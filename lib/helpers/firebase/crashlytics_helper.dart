import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class CrashlyticsHelper {
  static recordError(error, stack, [bool fatal = false]) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: fatal);
    return true;
  }

  static init() {
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    };
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: false);
      return true;
    };
  }
}
