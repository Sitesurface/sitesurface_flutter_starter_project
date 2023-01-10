import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

/// Function to show the loading without context.
showLoading() {
  BotToast.showCustomLoading(toastBuilder: (_) {
    return const CircularProgressIndicator.adaptive();
  });
}

/// Function to show the notification without context.
showNotification({required String title, String? subTitle}) {
  BotToast.showSimpleNotification(
      title: title,
      subTitle: subTitle,
      hideCloseButton: true,
      duration: const Duration(seconds: 5));
}

/// Function to close all loadings.
closeLoading() {
  BotToast.closeAllLoading();
}
