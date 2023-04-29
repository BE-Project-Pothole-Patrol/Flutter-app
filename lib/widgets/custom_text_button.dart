import 'package:flutter/material.dart';

import '../../../themes/theme_constants.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.size,
    required this.text,
    this.prefImagePath = "assets/images/googlelogo.png",
    this.hidePrefImage = false,
    this.isEnabled = true,
    required this.onTap,
  });

  final Size size;
  final String text;
  final String prefImagePath;
  final bool hidePrefImage;
  final bool isEnabled;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: !isEnabled ? null : () {
        onTap();
      },
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
          if (!hidePrefImage)
            Image.asset(
              prefImagePath,
              width: 25,
              height: 25,
            ),
          if (!hidePrefImage)
            SizedBox(
              width: size.width * 0.03,
            ),
          Text(
            text,
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
