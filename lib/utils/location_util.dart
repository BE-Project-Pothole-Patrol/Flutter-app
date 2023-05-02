import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationUtil {
  static final _location = Location();

  static Future<LocationData> getUserLocation() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        throw Exception("Location Not Enabled!");
      }
    }

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw Exception("Permission Not Granted");
      }
    }

    return await _location.getLocation();
  }

  static Future<StreamSubscription<LocationData>> getUserLocationUpdates(
      Function(LocationData) onLocationChange) async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        throw Exception("Location Not Enabled!");
      }
    }

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw Exception("Permission Not Granted");
      }
    }

    final locationSubscription = _location.onLocationChanged.listen((event) {
      onLocationChange(event);
    });

    return locationSubscription;
  }

  static Future<bool> stopLocationUpdates(StreamSubscription<LocationData> locationSubscription) async {
    try {
      await locationSubscription.cancel();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
