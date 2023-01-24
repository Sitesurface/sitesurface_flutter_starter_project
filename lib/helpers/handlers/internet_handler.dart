import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:sitesurface_flutter_starter_project/constants/assets/asset_constants.dart';

import 'package:sitesurface_flutter_starter_project/styles/colors/pallet.dart';
import 'package:sitesurface_flutter_starter_project/util/asset_helper/asset_helper.dart';
import 'package:sitesurface_flutter_starter_project/util/extentions/extensions.dart';

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
            if (!internetAvailable) const MaterialApp(home: _NoNetwork()),
          ],
        );
      },
    );
  }
}

class _NoNetwork extends StatefulWidget {
  const _NoNetwork({Key? key}) : super(key: key);

  @override
  State<_NoNetwork> createState() => _NoNetworkState();
}

class _NoNetworkState extends State<_NoNetwork> {
  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: colorScheme.white,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AssetHelper(image: AssetConstants.imageNoNetwork),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    Text(
                      "No Internet",
                      style: textTheme.headline4?.copyWith(
                        color: colorScheme.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Something wrong with your connection,\nplease check and try again.",
                      style: textTheme.caption?.copyWith(
                        color: colorScheme.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
