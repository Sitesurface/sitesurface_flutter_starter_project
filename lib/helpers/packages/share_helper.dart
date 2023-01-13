import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareHelper {
  static Future<void> share({required String text, String? subject}) async {
    try {
      await Share.share(text, subject: subject);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
