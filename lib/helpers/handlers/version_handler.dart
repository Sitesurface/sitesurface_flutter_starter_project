import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../cache/prefs_constant.dart';
import '../../cache/shared_preferences.dart';
import '../../constants/assets/asset_constants.dart';
import '../packages/package_info_helper.dart';
import '../../main.dart';
import '../../widgets/screens/permission_widget.dart';

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

      var currentVersion = PackageInfoHelper.instance.packageInfo.version;
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
    var updateType = await getUpdateType();
    switch (updateType) {
      case _UpdateType.none:
        break;
      case _UpdateType.minor:
      case _UpdateType.major:
        Navigator.of(navigatorKey.currentState!.context).push(MaterialPageRoute(
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
    return PermissionWidget(
      image: AssetConstants.lottieUpdateAvailable,
      title: updateType == _UpdateType.major
          ? "An Exciting Update for You"
          : "A Quick Fix for You",
      subtitle: updateType == _UpdateType.major
          ? "We've added some amazing new features and made improvements for better performance. Update now!"
          : "We've squashed a few bugs and made some minor improvements. Update now for a better experience!",
      primaryButtonLabel: "Update",
      secondaryButtonLabel: updateType == _UpdateType.major ? null : "Later",
      onPrimaryButtonTapped: () {},
      onsecondaryButtonTapped: updateType == _UpdateType.major
          ? null
          : () {
              Navigator.of(navigatorKey.currentState!.context).maybePop();
            },
      allowBack: updateType == _UpdateType.minor,
    );
  }
}
