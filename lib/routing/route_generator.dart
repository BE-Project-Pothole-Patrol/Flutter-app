import 'package:flutter/material.dart';

import '../screens/get_otp_screen/get_otp_screen.dart';
import '../screens/login_screen/login_screen.dart';
import '../screens/main_screen/main_screen.dart';
import '../screens/onboarding_screen1.dart';
import '../screens/onboarding_screen2.dart';
import '../screens/register_screen/register_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/verify_otp_screen/verify_otp_screen.dart';
import 'args/get_otp_screen_args.dart';
import 'args/login_screen_args.dart';
import 'args/register_screen_args.dart';
import 'args/verify_otp_screen_args.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/splashScreen':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/onboardingScreen1':
        return MaterialPageRoute(builder: (_) => const OnboardingScreen1());
      case '/onboardingScreen2':
        return MaterialPageRoute(builder: (_) => const OnboardingScreen2());
      case '/generateOtpScreen':
        return MaterialPageRoute(builder: (_) {
          GetOtpScreenArgs args = settings.arguments as GetOtpScreenArgs;
          return GetOtpScreen(
            title: args.title,
          );
        });
      case '/verifyOtpScreen':
        return MaterialPageRoute(builder: (_) {
          VerifyOtpScreenArgs args = settings.arguments as VerifyOtpScreenArgs;
          return VerifyOtpScreen(
            number: args.number,
            code: args.code,
          );
        });
      case '/registerScreen':
        return MaterialPageRoute(builder: (_) {
          RegisterScreenArgs args = settings.arguments as RegisterScreenArgs;
          return RegisterScreen(
            number: args.number,
            code: args.code,
          );
        });
      case '/loginScreen':
        return MaterialPageRoute(builder: (_) {
          LoginScreenArgs args = settings.arguments as LoginScreenArgs;
          return LoginScreen(
            firstName: args.firstName,
            username: args.username,
            password: args.password,
          );
        });
      case '/mainScreen':
        return MaterialPageRoute(builder: (_) => const MainScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return const Scaffold(
          body: Center(
            child: Text('ERROR'),
          ),
        );
      },
    );
  }
}
