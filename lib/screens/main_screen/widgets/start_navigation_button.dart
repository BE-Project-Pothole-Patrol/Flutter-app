import 'package:flutter/material.dart';

import '../../../themes/theme_constants.dart';

class StartNavigationButton extends StatelessWidget {
  const StartNavigationButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          onTap();
        },
        style: Theme.of(context).textButtonTheme.style?.copyWith(
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
              ),
              elevation: MaterialStateProperty.resolveWith<double>(
                (states) {
                  return 5.0;
                },
              ),
              backgroundColor: MaterialStateColor.resolveWith(
                (states) {
                  if (states.contains(MaterialState.pressed)) {
                    return kWhiteDark.withOpacity(0.85);
                  } else if (states.contains(MaterialState.focused) ||
                      states.contains(MaterialState.hovered)) {
                    return kWhiteDark.withOpacity(0.85);
                  } else {
                    return Colors.white.withOpacity(0.85);
                  }
                },
              ),
              overlayColor: MaterialStateColor.resolveWith(
                  (states) => kWhiteDark.withOpacity(0.85)),
            ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16,
                color: kPrimaryColor,
              ),
        ),
      ),
    );
  }
}
