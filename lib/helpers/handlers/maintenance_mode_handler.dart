import 'package:flutter/material.dart';

class MaintenanceModeHandler extends StatefulWidget {
  const MaintenanceModeHandler({super.key, required this.child});
  final Widget child;

  @override
  State<MaintenanceModeHandler> createState() => _MaintenanceModeHandlerState();
}

class _MaintenanceModeHandlerState extends State<MaintenanceModeHandler> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
