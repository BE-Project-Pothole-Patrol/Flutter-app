import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../models/directions_model.dart';
import '../../../utils/secure_storage_util.dart';
import 'location_search_bar.dart';
import 'map_nav_input.dart';
import 'navigate_button.dart';
import 'start_navigation_button.dart';
import '../../../utils/constants.dart' as Constants;
import '../../../services/google_maps_api.dart';
import '../../../themes/theme_constants.dart';

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

  final Map<String, Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  bool _isExpanded = false;
  String _sourceId = '';
  String _destId = '';
  String _mode = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> _changeMapLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition newCameraPosition = CameraPosition(
      target: LatLng(lat, long),
      zoom: 18,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  Future<List<dynamic>> _fetchPotholeInfo() async {
    final res = await http.get(Uri.parse(Constants.localMainBaseUrl));

    if (res.statusCode == 200) {
      debugPrint('Successfully fetched pothole info');
      List<dynamic> potholeInfo = jsonDecode(res.body);
      debugPrint(potholeInfo.toString());
      return potholeInfo;
    } else {
      debugPrint('There was some error in fetching pothole info');
      throw Exception(res.body);
    }
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    debugPrint('Map has been created...');
    _controller.complete(controller);

    String locationStr = await SecureStorageUtil.getLastAccessedLocation();

    if (locationStr.isNotEmpty) {
      debugPrint("Last Acessed Location: $locationStr");
      double latitude = double.parse(locationStr.split(" ")[0]);
      double longitude = double.parse(locationStr.split(" ")[1]);

      await _changeMapLocation(latitude, longitude);
    }

    List<dynamic> potholeInfo = await _fetchPotholeInfo();

    setState(() {
      _markers.clear();
      for (final pothole in potholeInfo) {
        final marker = Marker(
          markerId: MarkerId(pothole['id'].toString()),
          position: LatLng(pothole['geo_location']['coordinates'][1],
              pothole['geo_location']['coordinates'][0]),
          infoWindow: InfoWindow(
            title: pothole['title'],
            snippet: pothole['desc'],
          ),
        );

        _markers[pothole['id'].toString()] = marker;
      }
    });
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
              onMapCreated: _onMapCreated,
              markers: _markers.values.toSet(),
              polylines: _polyline,
              padding: EdgeInsets.only(bottom: size.height * 0.45),
            ),
            if (_isExpanded)
              MapNavInput(
                size: size,
                onBackBtnPress: (val) {
                  setState(() {
                    _isExpanded = val;
                  });
                },
                onSourceSelect: (sourceId) {
                  debugPrint('Source Place Id $sourceId');
                  _sourceId = sourceId;
                },
                onDestinationSelect: (destId) {
                  debugPrint('Destination Place Id $destId');
                  _destId = destId;
                },
                onModeSelect: (mode) {
                  _mode = mode;
                },
              ),
            if (_isExpanded)
              Positioned(
                bottom: size.height * 0.03 + 65,
                child: SizedBox(
                  width: size.width * 0.85,
                  child: Row(
                    children: [
                      StartNavigationButton(
                        text: "Preview",
                        onTap: () async {
                          LatLng source =
                              await GoogleMapsApi.getCoordinatesFromId(
                                  _sourceId);
                          LatLng dest =
                              await GoogleMapsApi.getCoordinatesFromId(_destId);

                          _changeMapLocation(source.latitude, source.longitude);

                          Directions directions =
                              await GoogleMapsApi.getDirections(
                                  _sourceId, _destId, _mode);

                          setState(() {
                            _markers[_sourceId] = Marker(
                                markerId: MarkerId(_sourceId),
                                position: source,
                                infoWindow: const InfoWindow(
                                  title: "Source",
                                ),
                                icon: BitmapDescriptor.defaultMarkerWithHue(
                                    BitmapDescriptor.hueBlue));

                            _markers[_destId] = Marker(
                              markerId: MarkerId(_destId),
                              position: dest,
                              infoWindow: const InfoWindow(
                                title: "Destination",
                              ),
                              icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueBlue),
                            );

                            _polyline.clear();
                            _polyline.add(Polyline(
                              polylineId: PolylineId("$_sourceId#$_destId"),
                              visible: true,
                              //latlng is List<LatLng>
                              points: directions.polylinePoints
                                  .map((e) => LatLng(e.latitude, e.longitude))
                                  .toList(),
                              color: kPrimaryColorDark,
                            ));

                            _isExpanded = false;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      StartNavigationButton(
                        text: "Start",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            if (!_isExpanded)
              Positioned(
                bottom: size.height * 0.03 + 65,
                right: 10,
                child: NavigateButton(onPress: (val) {
                  setState(() {
                    _isExpanded = val;
                  });
                }),
              ),
            if (!_isExpanded)
              LocationSearchBar(
                width: size.width * 0.85,
                marginTop: size.height * 0.03,
                onPlaceSelect: (placeId) {
                  debugPrint('place_id selected: $placeId');

                  GoogleMapsApi.getCoordinatesFromId(placeId)
                      .then((coordinates) {
                    debugPrint(
                        "Place latitude:${coordinates.latitude} longitude:${coordinates.longitude}");
                    _changeMapLocation(
                        coordinates.latitude, coordinates.longitude);
                  }).catchError((e) {
                    debugPrint(e.toString());
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}
