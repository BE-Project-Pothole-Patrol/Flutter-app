import 'package:flutter/material.dart';

import '../../../themes/theme_constants.dart';

class CustomTextBtn extends StatelessWidget {
  const CustomTextBtn({
    super.key,
    required this.size,
    required this.text,
    this.prefImagePath = "assets/images/googlelogo.png",
    this.hidePrefImage = false,
  });

  final Size size;
  final String text;
  final String prefImagePath;
  final bool hidePrefImage;

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
