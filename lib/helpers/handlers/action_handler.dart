import 'package:flutter/material.dart';

import '../../main.dart';

class ActionHandler {
  static void handle(dynamic args) {
    try {
      if (args is Map<String, dynamic>) {
        if (args["action"] == "screen") {
          Navigator.pushNamed(
              navigatorKey.currentState!.context, args["screen"],
              arguments: args);
        }
      } else if (args is Uri) {
        if (args.queryParameters["action"] == "screen") {
          Navigator.pushNamed(navigatorKey.currentState!.context,
              args.queryParameters["screen"]!,
              arguments: args.queryParameters);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
