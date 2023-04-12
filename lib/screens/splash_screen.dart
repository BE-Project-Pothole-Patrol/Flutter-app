import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/shared_prefs_util.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SharedPreferencesManager prefs = SharedPreferencesManager();

    Timer(const Duration(seconds: 2,), () {
        prefs.isOnboardingCompleted().then((val) {
          if (val) {
            Navigator.of(context).pushReplacementNamed('/loginScreen',arguments: '',);
          } else {
            Navigator.of(context).pushReplacementNamed('/onboardingScreen1',arguments: '',);
          }
        },);
      },
    );

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.jpeg',
                width: size.width * 0.7,
                height: size.width * 0.7,
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Text(
                "PotNoHole",
                style: Theme.of(context).textTheme.displayLarge,
              )
            ],
          ),
        ),
      ),
    );
  }
}
