import 'package:flutter/material.dart';

class LinearProgressIndicatorWithText extends StatelessWidget {
  const LinearProgressIndicatorWithText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 20,
              ),
        ),
        const SizedBox(
          height: 20,
        ),
        LinearProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        ),
      ],
    );
  }
}
