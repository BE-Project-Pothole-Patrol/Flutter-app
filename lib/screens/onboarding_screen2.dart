import 'package:flutter/material.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

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
                'assets/images/onboarding2.jpg',
                width: size.width,
                height: size.width * 0.9,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              const Text(
                "Get Live Pothole Alerts",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              SizedBox(
                width: size.width * 0.8,
                child: Text(
                  "Korem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim",
                  style: TextStyle(
                    color: const Color(0xFF2E2E2E).withOpacity(0.7),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
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
