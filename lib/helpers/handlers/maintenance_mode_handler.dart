import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:sitesurface_flutter_starter_project/constants/assets/asset_constants.dart';
import 'package:sitesurface_flutter_starter_project/main.dart';
import 'package:sitesurface_flutter_starter_project/util/date/date_helper.dart';
import 'package:sitesurface_flutter_starter_project/widgets/screens/permission_widget.dart';

class MaintenanceModeHandler extends StatefulWidget {
  const MaintenanceModeHandler({super.key, required this.child});
  final Widget child;

  @override
  State<MaintenanceModeHandler> createState() => _MaintenanceModeHandlerState();
}

class _MaintenanceModeHandlerState extends State<MaintenanceModeHandler> {
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

  static Future<String?> getMaintenanceUpdate() async {
    try {
      var maintenance = (await FirebaseFirestore.instance
              .collection("constants")
              .doc("constants")
              .get())
          .data()!["maintenance"];
      if (maintenance != null &&
          maintenance[Platform.isAndroid ? "android" : "ios"]) {
        var endDate = DateHelper.getDateFromString(maintenance["end_date"]);
        return endDate;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  static Future<void> _checkMaintenanceMode() async {
    var maintenanceModeEndDate = await getMaintenanceUpdate();

    if (maintenanceModeEndDate != null) {
      Navigator.of(navigatorKey.currentState!.context).push(MaterialPageRoute(
          builder: (context) => _MaintenanceModeScreen(
                endDate: maintenanceModeEndDate,
              )));
    }
  }
}

class _MaintenanceModeScreen extends StatelessWidget {
  final String? endDate;
  const _MaintenanceModeScreen({
    Key? key,
    required this.endDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PermissionWidget(
      image: AssetConstants.lottieMaintenance,
      title: "Maintenance in Progress",
      subtitle:
          "We're currently performing maintenance on our servers. Please check back later for an improved experience.\n\n\nEstimated Maintenance End Date: $endDate",
      allowBack: false,
      primaryButtonLabel: "OK",
      onPrimaryButtonTapped: () {},
    );
  }
}
