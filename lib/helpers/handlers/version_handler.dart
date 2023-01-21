import 'package:flutter/src/widgets/framework.dart';

class VersionHandler extends StatefulWidget {
  const VersionHandler({super.key, required this.child});
  final Widget child;

  @override
  State<VersionHandler> createState() => _VersionHandlerState();
}

class _VersionHandlerState extends State<VersionHandler> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
