import 'package:flutter/material.dart';

import '../../themes/theme_constants.dart';
import 'widgets/user_input_for_otp.dart';


class GetOtpScreen extends StatelessWidget {
  const GetOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List<PhoneCodeModel> list = [
      PhoneCodeModel(id: 0, phoneCode: '+91', countryCode: 'in',countryName: 'India'),
      PhoneCodeModel(id: 1, phoneCode: '+1', countryCode: 'us',countryName: 'US'),
      PhoneCodeModel(id: 2, phoneCode: '+44', countryCode: 'gb-eng',countryName: 'UK'),
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.06,
                ),
                Image.asset(
                  'assets/images/getotp.jpg',
                  width: size.width * 0.8,
                  height: size.width * 0.8,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  "Enter Your Mobile No.",
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
                  height: size.height * 0.035,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        '/verifyOtpScreen',
                          arguments: '',
                      );
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

