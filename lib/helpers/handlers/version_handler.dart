import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:sitesurface_flutter_starter_project/cache/prefs_constant.dart';
import 'package:sitesurface_flutter_starter_project/cache/shared_preferences.dart';
import 'package:sitesurface_flutter_starter_project/constants/assets/asset_constants.dart';
import 'package:sitesurface_flutter_starter_project/helpers/packages/package_info_helper.dart';
import 'package:sitesurface_flutter_starter_project/widgets/screens/permission_widget.dart';

class VersionHandler extends StatefulWidget {
  const VersionHandler({super.key, required this.child});
  final Widget child;

  @override
  State<VersionHandler> createState() => _VersionHandlerState();
}

class _VersionHandlerState extends State<VersionHandler> {
  final _pref = Pref.instance.pref;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkVersion();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  Future<_UpdateType> getUpdateType() async {
    try {
      var latestVersion = (await FirebaseFirestore.instance
              .collection("constants")
              .doc("constants")
              .get())
          .data()!["version"][Platform.isAndroid ? "android" : "ios"];

      var currentVersion =
          PackageInfoHelper.instance.packageInfo?.version ?? "";
      var skippedVersion = _pref.getString(PrefConstant.skippedVersion);

      var splitCurrentVersion = currentVersion.split('.');
      var splitLatestVersion = latestVersion.split('.');
      if (int.parse(splitCurrentVersion[0]) <
          int.parse(splitLatestVersion[0])) {
        return _UpdateType.major;
      }
      if (int.parse(splitCurrentVersion[0]) >
          int.parse(splitLatestVersion[0])) {
        return _UpdateType.none;
      }
      if (skippedVersion != latestVersion) {
        if (int.parse(splitCurrentVersion[1]) <
            int.parse(splitLatestVersion[1])) {
          return _UpdateType.minor;
        }
      }
      if (int.parse(splitCurrentVersion[2]) <
          int.parse(splitLatestVersion[2])) {
        return _UpdateType.none;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return _UpdateType.none;
  }

  Future<void> checkVersion() async {
    var navigator = Navigator.of(context);
    var updateType = await getUpdateType();
    switch (updateType) {
      case _UpdateType.none:
        break;
      case _UpdateType.minor:
        navigator.push(MaterialPageRoute(
            builder: (context) => _UpdateScreen(updateType: updateType)));
        break;
      case _UpdateType.major:
        navigator.push(MaterialPageRoute(
            builder: (context) => _UpdateScreen(updateType: updateType)));
        break;
    }
  }
}

enum _UpdateType { none, minor, major }

class _UpdateScreen extends StatelessWidget {
  final _UpdateType updateType;
  const _UpdateScreen({
    Key? key,
    required this.updateType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PermissionWidget(image: AssetConstants.lottieUpdateAvailable);
  }
}
