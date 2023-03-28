import 'package:flutter/material.dart';
import 'theme/theme_constants.dart';
import 'theme/theme_manager.dart';
import 'screens/onboarding_screen1.dart';
import 'screens/onboarding_screen2.dart';

void main() {
  runApp(const MyApp());
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      home: const OnboardingScreen2(),
    );
  }
}
