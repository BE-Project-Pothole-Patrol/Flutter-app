import 'package:flutter/material.dart';

import '../../../themes/theme_constants.dart';

class GoogleAuthTextBtn extends StatelessWidget {
  const GoogleAuthTextBtn({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: Theme.of(context).textButtonTheme.style?.copyWith(
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            overlayColor:
                MaterialStateColor.resolveWith((states) => kWhiteDarker),
            backgroundColor: MaterialStateColor.resolveWith(
              (states) {
                if (states.contains(MaterialState.pressed)) {
                  return kWhiteDarker;
                } else if (states.contains(MaterialState.disabled)) {
                  return kWhiteDark.withOpacity(0.5);
                } else if (states.contains(MaterialState.hovered)) {
                  return kWhiteDarker;
                } else {
                  return kWhiteDark;
                }
              },
            ),
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/googlelogo.png",
            width: 25,
            height: 25,
          ),
          SizedBox(
            width: size.width * 0.03,
          ),
          Text(
            "Sign Up with Google",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  color: kPrimaryColor,
                ),
          ),
        ],
      ),
    );
  }
}
