import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../models/directions_model.dart';
import '../utils/location_util.dart';
import '../utils/constants.dart' as Constants;

class GoogleMapsApi {
  static Future<List<List<String>>> fetchQueryMatches(String query,{bool isSourceQuery=false}) async {
    String encodedQuery = query.trim().replaceAll(" ", "%20");
    final userLocation = await LocationUtil.getUserLocation();
    String autocompleteUrl =
        "${Constants.placesAutocompleteBaseUrl}?input=$encodedQuery&radius=4000000&location=${userLocation.latitude}%2C${userLocation.longitude}&key=${Constants.apiKey}";

    final res = await http.get(Uri.parse(autocompleteUrl));

    if (res.statusCode == 200) {
      debugPrint('Success!');
      debugPrint(res.body);

      Map<String, dynamic> data = jsonDecode(res.body);

      List<List<String>> places = [];

      if (isSourceQuery) {
        places.add([
          "Your Location",
          "${userLocation.latitude}%2C${userLocation.longitude}",
          "USER_LOCATION_FIELD"
        ]);
      }

      for (final place in data['predictions']) {
        places.add([place['description'], place['place_id']]);
      }

      return places;
    } else {
      debugPrint('There was some error in fetching places...');
      debugPrint(res.body);
      throw Exception('Error :(');
    }
  }

  static Future<LatLng> getCoordinatesFromId(String placeId) async {
    String placeDetailsUrl =
        "${Constants.placesDetailsBaseUrl}?place_id=$placeId&key=${Constants.apiKey}";

    final res = await http.get(Uri.parse(placeDetailsUrl));

    if (res.statusCode == 200) {
      debugPrint('Successfully fetched place details');
      debugPrint(res.body);
      final placeDetails = jsonDecode(res.body);
      LatLng placeCoordinates = LatLng(
        placeDetails['result']['geometry']['location']['lat'],
        placeDetails['result']['geometry']['location']['lng'],
      );
      return placeCoordinates;
    } else {
      debugPrint('Error in fetching place details');
      debugPrint(res.body);

      throw Exception("Error in fetching place details :(");
    }
  }

  static Future<Directions> getDirections(
      String source, String destination, String mode,bool isSourceLatLng) async {

    String directionsUrl = !isSourceLatLng ?
        "${Constants.getDirectionsBaseUrl}?origin=place_id:$source&destination=place_id:$destination&mode=$mode&key=${Constants.apiKey}"
        :"${Constants.getDirectionsBaseUrl}?origin=$source&destination=place_id:$destination&mode=$mode&key=${Constants.apiKey}";
    final res = await http.get(Uri.parse(directionsUrl));

    if (res.statusCode == 200) {
      debugPrint('Directions fetched sucessfully');
      return Directions.fromMap(jsonDecode(res.body));
    } else {
      debugPrint('Error in fetching directions');
      debugPrint(res.body);

      throw Exception("Error in fetching directions :(");
    }
  }
}
