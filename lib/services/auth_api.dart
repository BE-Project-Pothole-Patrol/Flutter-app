import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/error_model.dart';
import '../models/jwt_token_model.dart';
import '../models/login_fail_model.dart';
import '../models/number_verified_model.dart';
import '../models/otp_model.dart';
import '../models/refresh_error_model.dart';
import '../models/user_created_model.dart';
import '../utils/constants.dart' as Constants;

class AuthApi {
  static Future<JwtTokenModel> refreshToken(String refresh) async {
    final res = await http.post(
      Uri.parse("${Constants.localAuthBaseUrl}token/refresh/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          "refresh": refresh,
        },
      ),
    );

    if (res.statusCode == 200) {
      debugPrint("Successfully refreshed!");
      debugPrint(res.body);
      return JwtTokenModel.fromJson(jsonDecode(res.body));
    } else {
      RefreshErrorModel err = RefreshErrorModel.fromJson(jsonDecode(res.body));
      throw Exception("code:${err.code}\ndetail:${err.detail}");
    }
  }

  static Future<JwtTokenModel> loginUser(String username, String password) async {
    final res = await http.post(
      Uri.parse("${Constants.localAuthBaseUrl}token/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          "username": username,
          "password": password,
        },
      ),
    );

    if (res.statusCode == 200) {
      debugPrint("Successfully logged in!");
      debugPrint(res.body);
      return JwtTokenModel.fromJson(jsonDecode(res.body));
    } else {
      LoginErrorModel err = LoginErrorModel.fromJson(jsonDecode(res.body));
      throw Exception(err.detail);
    }
  }

  static Future<Otp> getOtp(int countryCode, int number) async {
    final res = await http.post(
      Uri.parse("${Constants.localAuthBaseUrl}generateOTP/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, int>{
          "country_code": countryCode,
          "number": number,
        },
      ),
    );

    if (res.statusCode == 200) {
      return Otp.fromJson(jsonDecode(res.body));
    } else {
      ErrorRes err = ErrorRes.fromJson(jsonDecode(res.body));
      throw Exception(err.error);
    }
  }

  static Future<Verified> verifyUser(
      int countryCode, int number, String otp) async {
    final res = await http.post(
      Uri.parse("${Constants.localAuthBaseUrl}verifyOTP/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          "country_code": countryCode,
          "number": number,
          "otp": otp,
        },
      ),
    );

    if (res.statusCode == 200) {
      debugPrint("Success!");
      return Verified.fromJson(jsonDecode(res.body));
    } else {
      ErrorRes err = ErrorRes.fromJson(jsonDecode(res.body));
      throw Exception(err.error);
    }
  }

  static Future<UserCreatedModel> registerUser(
      Map<String, String> userData, int code, int number) async {
    final res = await http.post(
      Uri.parse("${Constants.localAuthBaseUrl}registerUser/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          "first_name": userData["firstName"],
          "last_name": userData["lastName"],
          "username": userData["username"],
          "email": userData["email"],
          "password": userData["password"],
          "number": number,
          "country_code": code,
        },
      ),
    );

    if (res.statusCode == 201) {
      debugPrint("Success!");
      debugPrint(res.body);
      return UserCreatedModel.fromJson(jsonDecode(res.body));
    } else {
      ErrorRes err = ErrorRes.fromJson(jsonDecode(res.body));
      throw Exception(err.error);
    }
  }
}
