import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utils/secure_storage_util.dart';
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

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(19.0760, 72.8777),
    zoom: 15,
  );

  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    SecureStorageUtil.getLastAccessedLocation().then((locationStr) {
      debugPrint("Last Acessed Location: $locationStr");
      if (locationStr.isEmpty) return;

      double latitude = double.parse(locationStr.split(" ")[0]);
      double longitude = double.parse(locationStr.split(" ")[1]);

      debugPrint("$latitude $longitude");
      _changeMapLocation(latitude,longitude);
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  Future<void> _changeMapLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition newCameraPosition = CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

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
              mapType: MapType.normal,
              initialCameraPosition: _initialPosition,
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
