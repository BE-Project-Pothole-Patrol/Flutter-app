import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../widgets/linear_progress_indicator_with_text.dart';
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
  bool isCameraInitialized = false;
  bool _isPending = false;
  late CameraDescription _camera;

  @override
  void initState() {
    super.initState();
    getSystemCamera().then((_) {
      debugPrint('Success in accessing system camera!');
      setState(() {
        isCameraInitialized = true;
      });
    }).catchError((e) {
      debugPrint('Error in accessing system camera..');
      debugPrint(e.toString());
    });
  }

  Future<void> getSystemCamera() async {
    final cameras = await availableCameras();
    _camera = cameras.first;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            _selected == 0
                ? Positioned.fill(
                    child: isCameraInitialized
                        ? ReportPotholesTab(
                            camera: _camera,
                            isPending: (val) {
                              setState(() {
                                _isPending = val;
                              });
                            },
                          )
                        : const LinearProgressIndicatorWithText(
                            text: "Trying to Acess Your Camera...",
                          ),
                  )
                : const Positioned.fill(
                    child: PotholesMapTab(),
                  ),
            if (!isKeyboard)
              Positioned(
                bottom: size.height * 0.03,
                child: CustomBottomNavBar(
                  width: size.width * 0.87,
                  horizontalPadding: size.width * 0.13,
                  onTabTapped: (pos) {
                    setState(
                      () {
                        _selected = pos;
                      },
                    );
                  },
                  selected: _selected,
                ),
              ),
            if (_isPending)
              Positioned.fill(
                child: Opacity(
                  opacity: 0.7,
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.black),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
