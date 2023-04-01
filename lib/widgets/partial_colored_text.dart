import 'package:flutter/material.dart';

import '../themes/theme_constants.dart';

class PartialColoredText extends StatelessWidget {
  const PartialColoredText({
    super.key,
    required this.normalText,
    required this.semiBoldText, 
    required this.color,
  });

  final String normalText;
  final String semiBoldText;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: kBlackLight.withOpacity(0.9),
            ),
        children: [
          TextSpan(text: normalText),
          TextSpan(
            text: semiBoldText,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w600, color: color),
          ),
        ],
      ),
    );
  }
}