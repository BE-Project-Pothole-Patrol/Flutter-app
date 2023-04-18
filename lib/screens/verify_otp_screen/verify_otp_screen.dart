import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../themes/theme_constants.dart';
import '../../models/error_model.dart';
import '../../models/number_verified_model.dart';
import '../../routing/args/register_screen_args.dart';
import '../../widgets/partial_colored_text.dart';
import 'widgets/otp_text_field.dart';
import '../../providers/otp_input_provider.dart';
import '../../utils/constants.dart' as Constants;
import '../../utils/shared_prefs_util.dart';
import '../../models/user_fields_model.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({super.key, required this.number, required this.code});
  final int number;
  final int code;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final SharedPreferencesManager prefs = SharedPreferencesManager();

    Future<Verified> verifyUser(int countryCode, int number, String otp) async {
      final res = await http.post(
        Uri.parse("${Constants.localBaseUrl}verifyOTP/"),
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

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/verifyotp.jpg',
                  width: size.width * 0.8,
                  height: size.width * 0.8,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  "Verify OTP",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: PartialColoredText(
                    normalText: "Enter OTP sent to ",
                    semiBoldText: "+$code $number",
                    color: Colors.black,
                    onTap: () {},
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: OtpTextField(width: size.width * 0.12),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: context.watch<OtpInputProvider>().isValid
                        ? () {
                            String otp = context.read<OtpInputProvider>().otp;
                            debugPrint(otp);

                            verifyUser(code, number, otp).then((value) {
                              debugPrint(value.success);
                              prefs.saveCurrentUser(User(code: code, number: number));
                              Navigator.of(context).pushNamed(
                              '/registerScreen',
                              arguments: RegisterScreenArgs(
                                number: number,
                                code: code,
                              ),
                            );
                            
                            }).catchError((e) {
                              debugPrint('error occured :(');
                              debugPrint(e);
                            });
                          }
                        : null,
                    style:
                        Theme.of(context).elevatedButtonTheme.style?.copyWith(
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                            ),
                    child: const Text('Verify'),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: PartialColoredText(
                    normalText: "Didn't Receive OTP? ",
                    semiBoldText: "Resend OTP",
                    color: kPrimaryColor,
                    onTap: () {},
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
