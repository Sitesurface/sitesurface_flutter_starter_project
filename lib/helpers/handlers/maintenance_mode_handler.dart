import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:sitesurface_flutter_starter_project/cache/shared_preferences.dart';
import 'package:sitesurface_flutter_starter_project/constants/assets/asset_constants.dart';
import 'package:sitesurface_flutter_starter_project/main.dart';
import 'package:sitesurface_flutter_starter_project/widgets/screens/permission_widget.dart';

class MaintenanceModeHandler extends StatefulWidget {
  const MaintenanceModeHandler({super.key, required this.child});
  final Widget child;

  @override
  State<MaintenanceModeHandler> createState() => _MaintenanceModeHandlerState();
}

class _MaintenanceModeHandlerState extends State<MaintenanceModeHandler> {
  final _pref = Pref.instance.pref;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkMaintenanceMode();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  Future<bool> _getMaintenanceUpdate() async {
    try {
      var maintenanceUpdate = (await FirebaseFirestore.instance
              .collection("constants")
              .doc("constants")
              .get())
          .data()!["maintenance_mode"][Platform.isAndroid ? "android" : "ios"];
      if (maintenanceUpdate != null) {
        return maintenanceUpdate;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  Future<void> _checkMaintenanceMode() async {
    var maintenanceMode = await _getMaintenanceUpdate();
    maintenanceMode = true;
    if (maintenanceMode) {
      Navigator.of(navigatorKey.currentState!.context).push(MaterialPageRoute(
          builder: (context) => const _MaintenanceModeScreen()));
    }
  }
}

class _MaintenanceModeScreen extends StatelessWidget {
  const _MaintenanceModeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PermissionWidget(
      image: AssetConstants.lottieMaintenance,
      title: "Maintenance in Progress",
      subtitle:
          "We're currently performing maintenance on our servers. Please check back later for an improved experience.",
      allowBack: false,
      primaryButtonLabel: "OK",
      onPrimaryButtonTapped: () {},
    );
  }
}
