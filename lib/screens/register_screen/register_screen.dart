import 'package:flutter/material.dart';

import '../../widgets/choice_divider.dart';
import '../../widgets/google_auth_text_btn.dart';
import '../../widgets/user_data_text_field.dart';
import '../../widgets/partial_colored_text.dart';
import '../../themes/theme_constants.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                  height: size.height * 0.02,
                ),
                Text(
                  "Sign Up",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  "Welcome!",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: kBlackLight.withOpacity(0.7),
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                UserDataTextField(
                  icName: Icons.person_2_outlined,
                  hint: "First Name",
                  width: size.width * 0.8,
                  spacing: size.width * 0.02,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                UserDataTextField(
                  icName: Icons.person_2_outlined,
                  hint: "Last Name",
                  width: size.width * 0.8,
                  spacing: size.width * 0.02,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                UserDataTextField(
                  icName: Icons.account_circle_outlined,
                  hint: "Username",
                  width: size.width * 0.8,
                  spacing: size.width * 0.02,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                UserDataTextField(
                  icName: Icons.email_outlined,
                  hint: "Email",
                  width: size.width * 0.8,
                  spacing: size.width * 0.02,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                UserDataTextField(
                  icName: Icons.vpn_key_outlined,
                  hint: "Password",
                  width: size.width * 0.8,
                  spacing: size.width * 0.02,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                UserDataTextField(
                  icName: Icons.vpn_key_outlined,
                  hint: "Confirm Password",
                  width: size.width * 0.8,
                  spacing: size.width * 0.02,
                ),
                SizedBox(
                  height: size.height * 0.06,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  height: 50,
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
                  child: GoogleAuthTextBtn(size: size),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: const PartialColoredText(normalText:"Already Have an Account? ",semiBoldText: "Sign In",color:kPrimaryColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
