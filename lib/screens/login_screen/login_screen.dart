import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/login_provider.dart';
import '../../routing/args/get_otp_screen_args.dart';
import '../../services/auth_api.dart';
import '../../themes/theme_constants.dart';
import '../../widgets/choice_divider.dart';
import '../../widgets/custom_text_button.dart';
import '../../widgets/user_data_text_field.dart';
import '../../widgets/partial_colored_text.dart';
import '../../utils/secure_storage_util.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
    required this.firstName,
    required this.username,
    required this.password,
  });

  final String firstName;
  final String username;
  final String password;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  "Sign In",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  firstName.isNotEmpty
                      ? "Welcome $firstName!"
                      : "Welcome back!",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: kBlackLight.withOpacity(0.7),
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Image.asset(
                  'assets/images/signin.jpg',
                  width: size.width * 0.6,
                  height: size.width * 0.45,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(
                  height: size.height * 0.005,
                ),
                UserDataTextField(
                  icName: Icons.email_outlined,
                  hint: "Username",
                  width: size.width * 0.8,
                  spacing: size.width * 0.02,
                  isValid: context.watch<LoginProvider>().isUsernameValid,
                  errorText: "Invalid Username",
                  onEdit: context.read<LoginProvider>().updateUsername,
                ),
                SizedBox(
                  height: size.height * 0.00,
                ),
                UserDataTextField(
                  icName: Icons.vpn_key_outlined,
                  hint: "Password",
                  width: size.width * 0.8,
                  spacing: size.width * 0.02,
                  isValid: context.watch<LoginProvider>().isPasswordValid,
                  errorText: "Invalid Password",
                  onEdit: context.read<LoginProvider>().updatePassword,
                  isPasswordText: true,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: Text(
                    "Forgot Password?",
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600, color: kPrimaryColor),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: context.watch<LoginProvider>().isValid
                        ? () {
                            Map<String, String> loginData =
                                context.read<LoginProvider>().getLoginData();
                            AuthApi.loginUser(loginData["username"] ?? '',loginData["password"] ?? '')
                              .then((token) {
                              debugPrint("Access Token: ${token.access}");
                              debugPrint("Refresh Token: ${token.refresh}");
                              SecureStorageUtil.saveCurrentAccessToken(token.access);
                              SecureStorageUtil.saveCurrentRefreshToken(token.refresh);

                              Navigator.of(context).pushReplacementNamed('/mainScreen',arguments: '',);
                            }).catchError((e) {
                              debugPrint('Some Error Occured:');
                              debugPrint(e.toString());
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
                    child: const Text('Sign Up'),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: ChoiceDivider(size: size),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  height: 50,
                  child: CustomTextButton(
                    size: size,
                    text: "Sign In with Google",
                    onTap: (){},
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: PartialColoredText(
                    normalText: "New User? ",
                    semiBoldText: "Sign Up",
                    color: kPrimaryColor,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/generateOtpScreen',
                        arguments: const GetOtpScreenArgs(
                            title: "Register Your Mobile No."),
                      );
                    },
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
