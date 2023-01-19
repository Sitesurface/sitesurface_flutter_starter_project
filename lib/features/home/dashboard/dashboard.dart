import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sitesurface_flutter_starter_project/cache/shared_preferences.dart';
import 'package:sitesurface_flutter_starter_project/constants/assets/asset_constants.dart';
import 'package:sitesurface_flutter_starter_project/features/home/splash/splash_screen.dart';
import 'package:sitesurface_flutter_starter_project/util/asset_helper/asset_helper.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  static const id = "/dashboard";

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
              onTap: () async {
                if (FirebaseAuth.instance.currentUser != null) {
                  await FirebaseAuth.instance.signOut();
                }
                Pref.instance.pref.clear();
                Navigator.pushNamed(context, SplashScreen.id);
              },
              child: const Icon(Icons.logout)),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: const [
            Text("Something"),
            AssetHelper(
              image: AssetConstants.imageApplelogo,
              fit: BoxFit.cover,
              height: 200,
              width: 200,
            ),
          ],
        ),
      ),
      // body: WebViewScreen(
      //     webViewData: WebViewData(uri: Uri.parse("https://sitesurface.com"))),
    );
  }
}
