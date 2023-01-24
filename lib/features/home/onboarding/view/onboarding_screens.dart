import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sitesurface_flutter_starter_project/util/extentions/extensions.dart';

import '../../../../cache/prefs_constant.dart';
import '../../../../cache/shared_preferences.dart';
import '../../auth/view/login_screen.dart';
import '../data/onboard_data.dart';
import '../widget/onboard_widget.dart';

class OnboardingScreen extends StatelessWidget {
  static const String id = "/onboarding";
  OnboardingScreen({Key? key}) : super(key: key);

  final data = OnboardData.onboardData;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final locale = context.l10n;
    return Scaffold(
      body: Stack(
        children: [
          ConcentricPageView(
            colors: data.map((e) => e.backgroundColor).toList(),
            itemCount: data.length,
            itemBuilder: (int index) {
              return OnboardCard(data: data[index]);
            },
            nextButtonBuilder: (context) {
              return const Center(
                child: Icon(MdiIcons.chevronRight),
              );
            },
            onFinish: () {
              Pref.instance.pref.setBool(PrefConstant.onboardCompleted, true);
              Navigator.pushReplacementNamed(context, LoginScreen.id);
            },
          ),
          Align(
            alignment: Alignment.topRight,
            child: SafeArea(
              child: TextButton(
                onPressed: () {
                  Pref.instance.pref
                      .setBool(PrefConstant.onboardCompleted, true);
                  Navigator.pushReplacementNamed(context, LoginScreen.id);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    locale.skip,
                    style: textTheme.bodyText1?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
