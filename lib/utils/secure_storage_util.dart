// ignore_for_file: constant_identifier_names

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageUtil {
  static const _storage = FlutterSecureStorage();

  static const String ACCESS_TOKEN = "access_token";
  static const String REFRESH_TOKEN = "refresh_token";
  static const String LAST_ACCESSED_LOCATION = "last_accessed_location";

  static Future<String> getCurrentAccessToken() async {
    return await _storage.read(key: ACCESS_TOKEN) ?? '';
  }

  static Future<void> saveCurrentAccessToken(String token) async {
    return await _storage.write(key: ACCESS_TOKEN, value: token);
  }

  static Future<String> getCurrentRefreshToken() async {
    return await _storage.read(key: REFRESH_TOKEN) ?? '';
  }

  static Future<void> saveCurrentRefreshToken(String token) async {
    return await _storage.write(key: REFRESH_TOKEN, value: token);
  }

  static Future<String> getLastAccessedLocation() async {
    return await _storage.read(key: LAST_ACCESSED_LOCATION) ?? '';
  }

  static Future<void> saveLastAccessedLocation(String location) async {
    return await _storage.write(key: LAST_ACCESSED_LOCATION, value: location);
  }
}
