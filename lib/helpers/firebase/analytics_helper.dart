import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class AnalyticsHelper {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  Future setUserProperties({required String userId}) async {
    try {
      await _analytics.setUserId(id: userId);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future setCurrentScreen({required String screenName}) async {
    try {
      await _analytics.setCurrentScreen(
          screenName: screenName, screenClassOverride: screenName);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future logScreen(String? screenName, String? className) async {
    try {
      await _analytics.logScreenView(
          screenName: screenName, screenClass: className);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

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

  Future logEvent(
      {required String eventName, Map<String, Object?>? parameters}) async {
    try {
      await _analytics.logEvent(name: eventName, parameters: parameters);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
