import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

/// Use [AnalyticsHelper] for accessing all Firebase Analytics functionalities.
class AnalyticsHelper {
  /// instance of [FirebaseAnalytics]
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  /// After the user logs in call this function to set the userId for current session
  /// This should be called as soon as user logs in like after login or successfull registration
  /// Here [userId] is the unique identifier for user
  Future setUserProperties({required String userId}) async {
    try {
      await _analytics.setUserId(id: userId);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// RouteObserver to log current screens
  FirebaseAnalyticsObserver getAnalyticsObserver() {
    return FirebaseAnalyticsObserver(analytics: _analytics);
  }

  /// When user is pushed to new screen you can call this function to set the current screen of user
  /// Currently calling this function is not required if [FirebaseAnalyticsObserver] is used in navigation observers.
  Future setCurrentScreen({required String screenName}) async {
    try {
      await _analytics.setCurrentScreen(
          screenName: screenName, screenClassOverride: screenName);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Logging actions of button press
  Future logAction(
    String actionName,
  ) async {
    try {
      await _analytics.logEvent(
          name: "action", parameters: {"action": "$actionName button pressed"});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Logging custom events. You can pass additional [parameters] as well
  Future logEvent(
      {required String eventName, Map<String, Object?>? parameters}) async {
    try {
      await _analytics.logEvent(name: eventName, parameters: parameters);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
