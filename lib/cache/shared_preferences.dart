import 'dart:io';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'prefs_constant.dart';

/// [Pref] is the singleton class that is used to get the user's preferences.
class Pref {
  static final Pref _obj = Pref._internal();

  static Pref get instance => _obj;

  late SharedPreferences pref;

  factory Pref() {
    return _obj;
  }

  Pref._internal();

  Future<void> init() async {
    pref = await SharedPreferences.getInstance();
    Directory tempDir = await getTemporaryDirectory();
    HydratedBloc.storage =
        await HydratedStorage.build(storageDirectory: tempDir);
  }

  Future<void> clear() async {
    String? theme = Pref.instance.pref.getString(
      PrefConstant.themeMode,
    );
    String? lang = Pref.instance.pref.getString(
      PrefConstant.language,
    );
    await pref.clear();
    await HydratedBloc.storage.clear();
    // pref.setBool(PrefConstant.onboardCompleted, true);
    if (theme != null) {
      Pref.instance.pref.setString(
        PrefConstant.themeMode,
        theme,
      );
    }
    if (lang != null) {
      Pref.instance.pref.setString(PrefConstant.language, lang);
    }
  }
}
