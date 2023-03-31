import 'package:flutter/material.dart';

class ChoiceDivider extends StatelessWidget {
  const ChoiceDivider({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: size.width * 0.35,
          child: const Divider(
            thickness: 0.5,
          ),
        ),
        const Text("OR"),
        SizedBox(
          width: size.width * 0.35,
          child: const Divider(
            thickness: 0.5,
          ),
        ),
      ],
    );
  }
}
