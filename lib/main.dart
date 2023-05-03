import 'package:app/providers/otp_input_provider.dart';
import 'package:app/providers/user_data_provider.dart';
import 'package:app/screens/register_screen/register_screen.dart';
import 'package:app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/login_provider.dart';
import 'routing/route_generator.dart';
import 'screens/login_screen/login_screen.dart';
import 'screens/main_screen/main_screen.dart';
import 'themes/theme_constants.dart';
import 'themes/theme_manager.dart';
import 'screens/onboarding_screen1.dart';
import 'screens/onboarding_screen2.dart';
import 'screens/get_otp_screen/get_otp_screen.dart';
import 'screens/verify_otp_screen/verify_otp_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => OtpInputProvider()),
      ChangeNotifierProvider(create: (_) => UserDataProvider()),
      ChangeNotifierProvider(create: (_) => LoginProvider()),
    ], 
    child: const MyApp()),
  );
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pothole Patrol',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      initialRoute: '/generateOtpScreen',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
