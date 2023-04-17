import 'package:flutter/material.dart';

import '../themes/theme_constants.dart';

class UserDataTextField extends StatelessWidget {
  const UserDataTextField({
    super.key,
    this.icName = Icons.person_2_outlined,
    required this.hint,
    required this.width,
    required this.spacing,
  });

  final IconData icName;
  final String hint;
  final double width;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        children:[ Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(
              icName,
              size: 30,
              color: kIconGrey,
            ),
            SizedBox(
              width: spacing,
            ),
            Expanded(
              child: TextField(
                textAlignVertical: TextAlignVertical.top,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: Theme.of(context).inputDecorationTheme.hintStyle?.copyWith(fontSize: 18),
                  errorText: null,
                  errorStyle: const TextStyle(
                    height: 0,
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 2),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),
            ),
          ],
        ),
         SizedBox(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: kErrorRed,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ),
        ),
      ],
      ),
    );
  }
}
