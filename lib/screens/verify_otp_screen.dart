import 'package:flutter/material.dart';
import '../../themes/theme_constants.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: size.width,
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
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: kBlackLight.withOpacity(0.7),
                          ),
                      children: [
                        const TextSpan(text: "Enter OTP sent to "),
                        TextSpan(
                          text: "+91 9820485183",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: size.width*0.1,
                        child: TextField(
                          textAlignVertical: TextAlignVertical.bottom,
                          textAlign:TextAlign.center,
                          maxLength: 1,
                          style: Theme.of(context).textTheme.bodyLarge,
                          decoration: InputDecoration(
                            hintText: '.',
                            hintStyle:Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: const Color(0xFFA8A8A8),fontWeight: FontWeight.bold),
                            counterText: ''
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width*0.1,
                        child: TextField(
                          textAlignVertical: TextAlignVertical.bottom,
                          textAlign:TextAlign.center,
                          maxLength: 1,
                          style: Theme.of(context).textTheme.bodyLarge,
                          decoration: InputDecoration(
                            hintText: '.',
                            hintStyle:Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: const Color(0xFFA8A8A8),fontWeight: FontWeight.bold),
                            counterText: ''
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width*0.1,
                        child: TextField(
                          textAlignVertical: TextAlignVertical.bottom,
                          textAlign:TextAlign.center,
                          maxLength: 1,
                          style: Theme.of(context).textTheme.bodyLarge,
                          decoration: InputDecoration(
                            hintText: '.',
                            hintStyle:Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: const Color(0xFFA8A8A8),fontWeight: FontWeight.bold),
                            counterText: ''
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width*0.1,
                        child: TextField(
                          textAlignVertical: TextAlignVertical.bottom,
                          textAlign:TextAlign.center,
                          maxLength: 1,
                          style: Theme.of(context).textTheme.bodyLarge,
                          decoration: InputDecoration(
                            hintText: '.',
                            hintStyle:Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: const Color(0xFFA8A8A8),fontWeight: FontWeight.bold),
                            counterText: ''
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: () {},
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
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: kBlackLight.withOpacity(0.9),
                          ),
                      children: [
                        const TextSpan(text: "Didn't Receive OTP? "),
                        TextSpan(
                          text: "Resend OTP",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600,color: kPrimaryColor),
                        ),
                      ],
                    ),
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
