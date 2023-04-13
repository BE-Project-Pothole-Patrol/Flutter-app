import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/error_model.dart';
import '../../models/otp_model.dart';
import '../../models/phone_code_model.dart';
import '../../utils/constants.dart' as Constants;
import '../../themes/theme_constants.dart';
import 'widgets/user_input_for_otp.dart';

class GetOtpScreen extends StatelessWidget {
  const GetOtpScreen({super.key, this.title = "Enter Your Mobile No."});

  final String title;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List<PhoneCodeModel> list = [
      PhoneCodeModel(
          id: 0, phoneCode: '+91', countryCode: 'in', countryName: 'India'),
    ];

    Future<Otp> getOtp(int countryCode, int number) async {
      final res = await http.post(
        Uri.parse("${Constants.localBaseUrl}generateOTP/"),
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

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/getotp.jpg',
                  width: size.width * 0.8,
                  height: size.width * 0.8,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: Text(
                    "We will send you an OTP (One Time Password) on your number",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: kBlackLight.withOpacity(0.7),
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: UserInputForOtp(list: list),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      getOtp(91, 9820696178).then((value) {
                        debugPrint(value.otp);
                      }).catchError((e) {
                        debugPrint('error occured :(');
                        debugPrint(e);
                      });
                      // Navigator.of(context).pushNamed(
                      //   '/verifyOtpScreen',
                      //   arguments: '',
                      // );
                    },
                    style:
                        Theme.of(context).elevatedButtonTheme.style?.copyWith(
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                            ),
                    child: const Text('Get OTP'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
