import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'location_search_bar.dart';
import 'map_nav_input.dart';
import 'navigate_button.dart';
import 'start_navigation_button.dart';

class PotholesMapTab extends StatefulWidget {
  const PotholesMapTab({super.key});

  @override
  State<PotholesMapTab> createState() => _PotholesMapTabState();
}

class _PotholesMapTabState extends State<PotholesMapTab> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              padding: EdgeInsets.only(bottom: size.height * 0.45),
            ),
            if (isExpanded)
              MapNavInput(
                size: size,
                onPress: (val) {
                  setState(() {
                    isExpanded = val;
                  });
                },
              ),
            if (isExpanded)
              Positioned(
                bottom: size.height * 0.03 + 65,
                child: SizedBox(
                  width: size.width * 0.85,
                  child: Row(
                    children: const [
                      StartNavigationButton(
                        text: "Preview",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      StartNavigationButton(
                        text: "Start",
                      ),
                    ],
                  ),
                ),
              ),
            if (!isExpanded)
              Positioned(
                bottom: size.height * 0.03 + 65,
                right: 10,
                child: NavigateButton(onPress: (val) {
                  setState(() {
                    isExpanded = val;
                  });
                }),
              ),
            if (!isExpanded)
              LocationSearchBar(
                width: size.width * 0.85,
                marginTop: size.height * 0.03,
              ),
          ],
        ),
      ),
    );
  }
}
