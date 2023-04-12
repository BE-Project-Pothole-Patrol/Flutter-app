import 'package:flutter/material.dart';

import '../themes/theme_constants.dart';
import '../utils/shared_prefs_util.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

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
                'assets/images/onboarding1.jpg',
                width: size.width * 0.9,
                height: size.width * 0.9,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                "Report Potholes",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              SizedBox(
                width: size.width * 0.8,
                child: Text(
                  "Korem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim",
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
                    TextButton(
                      onPressed: () {
                        prefs.setOnboardingCompleted(true);
                        Navigator.of(context).pushReplacementNamed(
                          '/loginScreen',
                          arguments: '',
                        );
                      },
                      child: const Text('Skip'),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(
                          '/onboardingScreen2',
                          arguments: '',
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
