import 'package:flutter/material.dart';
import 'package:sitesurface_flutter_starter_project/helpers/firebase/dynamic_link_helper.dart';

class CommonHandler extends StatefulWidget {
  const CommonHandler({super.key, required this.child});
  final Widget child;
  @override
  State<CommonHandler> createState() => _CommonHandlerState();
}

class _CommonHandlerState extends State<CommonHandler> {
  @override
  void initState() {
    //Dynamic Links
    DynamicLinkHelper.addFirebaseDynamicLinkListener();
    DynamicLinkHelper.initDynamicLink();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
