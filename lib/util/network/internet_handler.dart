import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'no_network_screen.dart';

class InternetHandler extends StatefulWidget {
  const InternetHandler({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<InternetHandler> createState() => _InternetHandlerState();
}

class _InternetHandlerState extends State<InternetHandler> {
  final Connectivity _connectivity = Connectivity();
  // ignore: unused_field
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final ValueNotifier<bool> _internetAvailable = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    initConnection();
  }

  Future<void> initConnection() async {
    try {
      ConnectivityResult result = await _connectivity.checkConnectivity();
      updateStatus(result);

      _connectivitySubscription =
          _connectivity.onConnectivityChanged.listen(updateStatus);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void updateStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      _internetAvailable.value = false;
    } else {
      _internetAvailable.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _internetAvailable,
      builder: (context, internetAvailable, _) {
        return Stack(
          textDirection: TextDirection.ltr,
          children: [
            widget.child,
            if (!internetAvailable) const MaterialApp(home: NoNetwork()),
          ],
        );
      },
    );
  }
}
