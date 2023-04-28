import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

import '../models/jwt_token_model.dart';
import '../models/refresh_error_model.dart';
import '../routing/args/login_screen_args.dart';
import '../utils/shared_prefs_util.dart';
// ignore: library_prefixes
import '../utils/constants.dart' as Constants;
import '../utils/secure_storage_util.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<JwtTokenModel> refreshToken(String refresh) async {
    final res = await http.post(
      Uri.parse("${Constants.localBaseUrl}token/refresh/"),
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

  @override
  Widget build(BuildContext context) {
    final SharedPreferencesManager prefs = SharedPreferencesManager();

    Timer(const Duration(seconds: 2,),() {
      prefs.isOnboardingCompleted().then((val) {
        debugPrint("isOnboardingComplete: $val");
        if (val) {
              SecureStorageUtil.getCurrentAccessToken().then((aToken) {
                debugPrint("Current Access Token: $aToken");
                bool hasAccessTokenExpired = aToken.isEmpty || JwtDecoder.isExpired(aToken);
                debugPrint("Has Access Token Expired: $hasAccessTokenExpired");
                if (hasAccessTokenExpired) {
                  SecureStorageUtil.getCurrentRefreshToken().then((rToken) {
                    debugPrint("Current Refresh Token: $rToken");
                    bool hasRefreshTokenExpired = rToken.isEmpty || JwtDecoder.isExpired(rToken);
                    debugPrint("Has Refresh Token Expired: $hasRefreshTokenExpired");
                    if(hasRefreshTokenExpired){
                      debugPrint('Both Access and Refresh Tokens have expired/are empty!');
                      debugPrint('Please login/login again!');
                      Navigator.of(context).pushReplacementNamed('/loginScreen',
                      arguments: const LoginScreenArgs(),
                      );
                    }else{
                      debugPrint('Refreshing token...');

                      refreshToken(rToken).then((value){
                        debugPrint("New Access Token: ${value.access}");
                        debugPrint("New Refresh Token: ${value.refresh}");
                        SecureStorageUtil.saveCurrentAccessToken(value.access);
                        SecureStorageUtil.saveCurrentRefreshToken(value.refresh);
                        Navigator.of(context).pushReplacementNamed('/mainScreen',arguments: '',);
                      }).catchError((e){
                        debugPrint('Error in refreshing..');
                        debugPrint(e.toString());
                      });
                    }
                  }).catchError((e) {
                    debugPrint(e.toString());
                  });
                }else{
                  Navigator.of(context).pushReplacementNamed('/mainScreen',arguments: '',);
                }
              }).catchError((e) {
                debugPrint(e.toString());
              });
            } else {
              Navigator.of(context).pushReplacementNamed(
                '/onboardingScreen1',
                arguments: '',
              );
            }
          },
        );
      },
    );

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.jpeg',
                width: size.width * 0.7,
                height: size.width * 0.7,
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Text(
                "Pothole Patrol",
                style: Theme.of(context).textTheme.displayLarge,
              )
            ],
          ),
        ),
      ),
    );
  }
}
