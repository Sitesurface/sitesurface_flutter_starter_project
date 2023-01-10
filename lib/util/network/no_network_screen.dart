import 'package:flutter/material.dart';
import 'package:sitesurface_flutter_starter_project/util/styles/colors/pallet.dart';
import 'package:sitesurface_flutter_starter_project/util/styles/theme/theme_ext.dart';

class NoNetwork extends StatefulWidget {
  const NoNetwork({Key? key}) : super(key: key);
  static const id = "no-network";

  @override
  State<NoNetwork> createState() => _NoNetworkState();
}

class _NoNetworkState extends State<NoNetwork> {
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
                Image.asset(
                  "assets/images/no_network.png",
                ),
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
