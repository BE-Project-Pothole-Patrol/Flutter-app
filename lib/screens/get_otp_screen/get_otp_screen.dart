import 'package:flutter/material.dart';

import '../../models/phone_code_model.dart';
import '../../routing/args/verify_otp_screen_args.dart';
import '../../services/auth_api.dart';
import '../../themes/theme_constants.dart';
import '../../widgets/linear_progress_indicator_with_text.dart';
import 'widgets/user_input_for_otp.dart';

class GetOtpScreen extends StatefulWidget {
  const GetOtpScreen({
    super.key,
    this.title = "Enter Your Mobile No.",
  });

  final String title;

  @override
  State<GetOtpScreen> createState() => _GetOtpScreenState();
}

class _GetOtpScreenState extends State<GetOtpScreen> {
  bool _isLoading = false;
  bool _isEnabled = false;
  bool _isError = false;
  String _error = '';
  String _userNumberVal = '';
  String _userCodeVal = '+91';

  @override
  void initState() {
    super.initState();
    debugPrint('init get OTP screen');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("in get opt screen build()");
    final Size size = MediaQuery.of(context).size;

    final List<PhoneCodeModel> phoneCodeList = [
      PhoneCodeModel(
          id: 0, phoneCode: '+91', countryCode: 'in', countryName: 'India'),
    ];

    return Scaffold(
      appBar: !_isLoading ? AppBar() : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: !_isLoading
                ? Column(
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
                        widget.title,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      SizedBox(
                        width: size.width * 0.8,
                        child: Text(
                          "We will send you an OTP (One Time Password) on your number",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                        child: UserInputForOtp(
                          list: phoneCodeList,
                          isError: _isError,
                          error: _error,
                          onTextChanged: (val) {
                            debugPrint('number from the child widget: $val');

                            if (val.isEmpty) {
                              setState(() {
                                _isError = true;
                                _error = "Can't be empty!";
                                _isEnabled = false;
                              });
                            } else if (val.length < 10) {
                              setState(() {
                                _isError = true;
                                _error = "Number must be of 10 digits";
                                _isEnabled = false;
                              });
                            } else {
                              setState(() {
                                _isError = false;
                                _error = '';
                                _isEnabled = true;
                              });
                            }

                            _userNumberVal = val;
                          },
                          onSelectionChanged: (val) {
                            debugPrint('code from the child widget: $val');
                            _userCodeVal = val;
                          },
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      SizedBox(
                        width: size.width * 0.8,
                        child: ElevatedButton(
                          onPressed: _isEnabled? () {
                                  debugPrint(_userCodeVal);
                                  debugPrint(_userNumberVal);
                                  int code = int.parse(_userCodeVal.substring(1));
                                  int number = int.parse(_userNumberVal);

                                  setState(() {
                                    _isLoading = true;
                                  });

                                  AuthApi.getOtp(code, number).then((value) {
                                    debugPrint(value.otp);
                                    Navigator.of(context).pushNamed('/verifyOtpScreen',
                                    arguments: VerifyOtpScreenArgs(number: number, code: code),
                                    );
                                  }).catchError((e) {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      content: Text("Could not get OTP, try sometime later..."),
                                    ));
                                    debugPrint('error occured :(');
                                    debugPrint(e);
                                  }).whenComplete((){
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  });
                                }
                              : null,
                          style: Theme.of(context)
                              .elevatedButtonTheme
                              .style
                              ?.copyWith(
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                              ),
                          child: const Text('Get OTP'),
                        ),
                      ),
                    ],
                  )
                : Container(
                    margin: EdgeInsets.only(top: size.height * 0.45),
                    width: size.width * 0.8,
                    child: const LinearProgressIndicatorWithText(
                        text: "Fetching Your OTP..."),
                  ),
          ),
        ),
      ),
    );
  }
}
