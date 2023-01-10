import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateHelper {
  static String? getDateFromString(String? date, {String? format}) {
    try {
      if (date != null) {
        final DateTime dateTime = DateTime.parse(date).toLocal();
        return DateFormat(format ?? "dd MMM yyyy").format(dateTime.toLocal());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  static String? getDateFromDateTime(DateTime? date, [String? pattern]) {
    if (date != null) {
      return DateFormat(pattern ?? "dd MMM yyyy").format(date.toLocal());
    }
    return null;
  }
}
