// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static const String ONBOARDING_COMPLETED = "onboarding_completed";

  Future<bool> isOnboardingCompleted() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getBool(ONBOARDING_COMPLETED) ?? false;
  }

  Future<void> setOnboardingCompleted(bool val) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setBool(ONBOARDING_COMPLETED, val);
  }
}
