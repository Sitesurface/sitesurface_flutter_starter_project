import 'package:flutter/src/widgets/framework.dart';
import 'package:sitesurface_flutter_starter_project/helpers/firebase/dynamic_link_helper.dart';

import '../firebase/remote_config_helper.dart';

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

    // Default remote config values
    RemoteConfigHelper.setDefaults(const {
      "maintenance_mode": false,
      "version": "1.0.0",
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
