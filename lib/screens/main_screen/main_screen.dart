import 'package:flutter/material.dart';

import 'widgets/custom_bottom_nav_bar.dart';
import 'widgets/potholes_map_tab.dart';
import 'widgets/report_potholes_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selected = 0;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            _selected == 0
                ? const Positioned.fill(
                    child: ReportPotholesTab(),
                  )
                : const Positioned.fill(
                    child: PotholesMapTab(),
                  ),
            Positioned(
              bottom: size.height * 0.05,
              child: CustomBottomNavBar(
                width: size.width * 0.85,
                horizontalPadding: size.width * 0.1,
                onTabTapped: (pos) {
                  setState(() {
                      _selected = pos;
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
