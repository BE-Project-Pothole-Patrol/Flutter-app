import 'package:flutter/material.dart';

import '../../../themes/theme_constants.dart';
import '../../widgets/partial_colored_text.dart';
import 'widgets/otp_text_field.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                  'assets/images/verifyotp.jpg',
                  width: size.width * 0.8,
                  height: size.width * 0.8,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  "Verify OTP Screen",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: PartialColoredText(
                      normalText: "Enter OTP sent to ",
                      semiBoldText: "+91 9820485183",
                      color: Colors.black,
                      onTap: (){},),
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
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        '/loginScreen',
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
                      onTap: (){},),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
