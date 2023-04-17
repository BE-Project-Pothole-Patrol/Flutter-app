import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/choice_divider.dart';
import '../../widgets/custom_text_button.dart';
import '../../widgets/user_data_text_field.dart';
import '../../themes/theme_constants.dart';
import '../../providers/user_data_provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
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
                  height: size.height * 0.02,
                ),
                UserDataTextField(
                  icName: Icons.person_2_outlined,
                  hint: "First Name",
                  width: size.width * 0.8,
                  spacing: size.width * 0.02,
                  isValid: context.watch<UserDataProvider>().isFirstNameValid,
                  errorText: "Can't be Empty!",
                  onEdit: context.read<UserDataProvider>().updateFirstName,
                ),
                SizedBox(
                  height: size.height * 0.0,
                ),
                UserDataTextField(
                  icName: Icons.person_2_outlined,
                  hint: "Last Name",
                  width: size.width * 0.8,
                  spacing: size.width * 0.02,
                  isValid: context.watch<UserDataProvider>().isLastNameValid,
                  errorText: "Can't be empty!",
                  onEdit: context.read<UserDataProvider>().updateLastName,
                ),
                SizedBox(
                  height: size.height * 0.0,
                ),
                UserDataTextField(
                  icName: Icons.account_circle_outlined,
                  hint: "Username",
                  width: size.width * 0.8,
                  spacing: size.width * 0.02,
                  isValid: context.watch<UserDataProvider>().isUsernameValid,
                  errorText: "Must be at least 5 characters!",
                  onEdit: context.read<UserDataProvider>().updateUsername,
                ),
                SizedBox(
                  height: size.height * 0.0,
                ),
                UserDataTextField(
                  icName: Icons.email_outlined,
                  hint: "Email",
                  width: size.width * 0.8,
                  spacing: size.width * 0.02,
                  isValid: context.watch<UserDataProvider>().isEmailValid,
                  errorText: "Invalid Email!",
                  onEdit: context.read<UserDataProvider>().updateEmail,
                ),
                SizedBox(
                  height: size.height * 0.0,
                ),
                UserDataTextField(
                  icName: Icons.vpn_key_outlined,
                  hint: "Password",
                  width: size.width * 0.8,
                  spacing: size.width * 0.02,
                  isValid: context.watch<UserDataProvider>().isPasswordValid,
                  errorText: "Enter a Strong Password!",
                  onEdit: context.read<UserDataProvider>().updatePassword,
                ),
                SizedBox(
                  height: size.height * 0.0,
                ),
                UserDataTextField(
                  icName: Icons.vpn_key_outlined,
                  hint: "Confirm Password",
                  width: size.width * 0.8,
                  spacing: size.width * 0.02,
                  isValid:
                      context.watch<UserDataProvider>().isConfirmPasswordValid,
                  errorText: "Password is Invalid / Doesn't Match",
                  onEdit:
                      context.read<UserDataProvider>().updateConfirmPassword,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: context.watch<UserDataProvider>().isValid
                        ? () {
                            debugPrint(
                                context.read<UserDataProvider>().firstName);
                            // Navigator.of(context).pushNamed(
                            //     '/mainScreen',
                            //     arguments: '',
                            //   );
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
                  height: size.height * 0.01,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: ChoiceDivider(size: size),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  height: 50,
                  child: CustomTextButton(
                    size: size,
                    text: "Sign Up with Google",
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
