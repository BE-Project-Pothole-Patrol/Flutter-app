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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            icName,
            size: 32,
            color: kIconGrey,
          ),
          SizedBox(
            width: spacing,
          ),
          Expanded(
            child: TextField(
              textAlignVertical: TextAlignVertical.top,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w500, fontSize: 20),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: Theme.of(context)
                    .inputDecorationTheme
                    .hintStyle
                    ?.copyWith(fontSize: 20),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 5),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
