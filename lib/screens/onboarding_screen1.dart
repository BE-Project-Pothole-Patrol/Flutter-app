import 'package:flutter/material.dart';
import '../themes/theme_constants.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width,
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
                      onPressed: () {},
                      child: const Text('Skip'),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {},
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
