import 'package:flutter/material.dart';

import '../routing/args/login_screen_args.dart';
import '../themes/theme_constants.dart';
import '../utils/shared_prefs_util.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final SharedPreferencesManager prefs = SharedPreferencesManager();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/images/onboarding2.jpg',
                width: size.width,
                height: size.width * 0.9,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                "Get Live Pothole Alerts",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              SizedBox(
                width: size.width * 0.8,
                child: Text(
                  "Navigate with confidence and avoid damage to your vehicle. Our app displays potholes on your route and gives you a heads up.",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: kBlackLight.withOpacity(0.7),
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        prefs.setOnboardingCompleted(true);
                        Navigator.of(context).pushReplacementNamed(
                          '/loginScreen',
                          arguments: const LoginScreenArgs(),
                        );
                      },
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
