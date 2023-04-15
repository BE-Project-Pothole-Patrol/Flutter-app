// ignore_for_file: constant_identifier_names
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_fields_model.dart';

class SharedPreferencesManager {
  static const String ONBOARDING_COMPLETED = "onboarding_completed";
  static const String USER_FIELDS = "user";

  Future<bool> isOnboardingCompleted() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getBool(ONBOARDING_COMPLETED) ?? false;
  }

  Future<void> setOnboardingCompleted(bool val) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setBool(ONBOARDING_COMPLETED, val);
  }

  Future<void> saveCurrentUser(User user) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setString(USER_FIELDS, jsonEncode(user));
  }

  Future<String> getCurrentUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getString(USER_FIELDS) ?? '';
  }
}
