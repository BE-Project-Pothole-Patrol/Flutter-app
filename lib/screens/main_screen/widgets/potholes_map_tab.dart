import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

import '../../../models/directions_model.dart';
import '../../../utils/location_util.dart';
import '../../../utils/notification_util.dart';
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
  // final Completer<GoogleMapController> _controller =
  //     Completer<GoogleMapController>();

  late GoogleMapController _controller;
  late StreamSubscription<LocationData> _streamSubscription;

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(19.0760, 72.8777),
    zoom: 15,
  );

  final Map<String, Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  bool _isExpanded = false;
  String _sourceId = '';
  String _destId = '';
  String _mode = 'driving';
  bool _isUserLocnSource = false;
  bool _isUserNavigating = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _changeMapLocation(double lat, double long,
      {double zoom = 18}) async {
    CameraPosition newCameraPosition = CameraPosition(
      target: LatLng(lat, long),
      zoom: zoom,
    );
    _controller
        .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  Future<List<dynamic>> _fetchPotholeInfo() async {
    final res = await http.get(Uri.parse(Constants.localGetPotholeBaseUrl));

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

    _controller = controller;

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

  Future<List<dynamic>> _getPotholesWithinARadius(LocationData currentLoc, int radius) async {
    String url="${Constants.localGetPotholeBaseUrl}?dist=$radius&point=${currentLoc.longitude},${currentLoc.latitude}";
    final res = await http.get(Uri.parse(url));

    if(res.statusCode==200){
      debugPrint('Successfully fetched potholes near you');
      debugPrint(res.body);
      List<dynamic> potholeInfo = jsonDecode(res.body);
      return potholeInfo;
    }else{
      debugPrint('There was some error in fetching potholes near you');
      throw Exception(res.body);
    }
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
                onSourceSelect: (sourceId, isUserLocn) {
                  debugPrint('Source Place Id $sourceId');
                  _sourceId = sourceId;
                  _isUserLocnSource = isUserLocn;
                },
                onDestinationSelect: (destId) {
                  debugPrint('Destination Place Id $destId');
                  _destId = destId;
                },
                onModeSelect: (mode) {
                  debugPrint('selected mode $mode');
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
                          debugPrint(
                              "source $_sourceId dest $_destId $_isUserLocnSource");
                          LatLng source = !_isUserLocnSource
                              ? await GoogleMapsApi.getCoordinatesFromId(
                                  _sourceId)
                              : LatLng(double.parse(_sourceId.split("%2C")[0]),
                                  double.parse(_sourceId.split("%2C")[1]));
                          LatLng dest =
                              await GoogleMapsApi.getCoordinatesFromId(_destId);

                          _changeMapLocation(source.latitude, source.longitude);

                          Directions directions =
                              await GoogleMapsApi.getDirections(
                                  _sourceId, _destId, _mode, _isUserLocnSource);

                          setState(() {
                            _markers[Constants.sourceMarker] = Marker(
                              markerId: const MarkerId(Constants.sourceMarker),
                              position: source,
                              infoWindow: const InfoWindow(
                                title: "Source",
                              ),
                              icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueAzure),
                            );

                            _markers[Constants.destinationMarker] = Marker(
                              markerId:
                                  const MarkerId(Constants.destinationMarker),
                              position: dest,
                              infoWindow: const InfoWindow(
                                title: "Destination",
                              ),
                              icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueAzure),
                            );

                            _polyline.clear();
                            _polyline.add(Polyline(
                              polylineId:
                                  const PolylineId(Constants.previewPolyline),
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
                        onTap: () async {
                          LatLng source = LatLng(
                            double.parse(_sourceId.split("%2C")[0]),
                            double.parse(_sourceId.split("%2C")[1]),
                          );

                          LatLng destination =
                              await GoogleMapsApi.getCoordinatesFromId(_destId);

                          Directions directions =
                              await GoogleMapsApi.getDirections(
                                  _sourceId, _destId, _mode, true);

                          await _changeMapLocation(
                              source.latitude, source.longitude,
                              zoom: 30);

                          setState(() {
                            _isUserNavigating = true;
                            _markers[Constants.sourceMarker] = Marker(
                              markerId: const MarkerId(Constants.sourceMarker),
                              position: source,
                              infoWindow: const InfoWindow(
                                title: "Source",
                              ),
                              icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueAzure),
                            );

                            _markers[Constants.destinationMarker] = Marker(
                              markerId:
                                  const MarkerId(Constants.destinationMarker),
                              position: destination,
                              infoWindow: const InfoWindow(
                                title: "Destination",
                              ),
                              icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueAzure),
                            );

                            _polyline.clear();
                            _polyline.add(Polyline(
                              polylineId:
                                  const PolylineId(Constants.startPolyline),
                              visible: true,
                              points: directions.polylinePoints
                                  .map((e) => LatLng(e.latitude, e.longitude))
                                  .toList(),
                              color: kPrimaryColorDark,
                            ));

                            _isExpanded = false;
                          });

                          _streamSubscription = await LocationUtil.getUserLocationUpdates((location) async {
                            debugPrint('Location changed!');
                            debugPrint("lat: ${location.latitude} long: ${location.longitude}");
                            List<dynamic> nearbyPotholesList = await _getPotholesWithinARadius(location, 30);

                            for(final pothole in nearbyPotholesList){
                              NotificationUtil.showNotification(
                                id:pothole['id'],
                                title: pothole['title'],
                                body: pothole['desc']
                              );
                            }

                            directions = await GoogleMapsApi.getDirections("${location.latitude}%2C${location.longitude}",_destId, _mode,true);

                            await _changeMapLocation(location.latitude!, location.longitude!,zoom: 30);
                            setState(() {
                              _markers.clear();
                              _markers[Constants.commuterMarker] = Marker(
                                markerId:
                                    const MarkerId(Constants.commuterMarker),
                                position: LatLng(
                                    location.latitude!, location.latitude!),
                                infoWindow: const InfoWindow(
                                  title: "You",
                                ),
                                icon: BitmapDescriptor.defaultMarkerWithHue(
                                    BitmapDescriptor.hueBlue),
                              );

                              _polyline.clear();

                              _polyline.add(Polyline(
                                polylineId:
                                    const PolylineId(Constants.startPolyline),
                                visible: true,
                                points: directions.polylinePoints
                                    .map((e) => LatLng(e.latitude, e.longitude))
                                    .toList(),
                                color: kPrimaryColorDark,
                              ));
                            });
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            if (!_isExpanded)
              Positioned(
                bottom: size.height * 0.03 + 65,
                right: 10,
                child: NavigateButton(
                    iconData:
                        !_isUserNavigating ? Icons.turn_right : Icons.clear,
                    onPress: (val) {
                      if (_isUserNavigating) {
                        _streamSubscription.cancel();
                      }
                      setState(() {
                        if (_isUserNavigating) {
                          _isUserNavigating = false;
                        }
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
