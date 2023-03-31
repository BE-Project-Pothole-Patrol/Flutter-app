import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../themes/theme_constants.dart';

class UserDataField extends StatelessWidget {
  const UserDataField(
      {super.key,
      this.icName = Icons.person_2_outlined,
      required this.hint,
      required this.width,
      required this.spacing,
      this.usesSvg = false,
      this.svgName = ''});

  final IconData icName;
  final String hint;
  final double width;
  final double spacing;
  final bool usesSvg;
  final String svgName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          !usesSvg
              ? Icon(
                  icName,
                  size: 35,
                  color: kIconGrey,
                )
              : SvgPicture.asset(
                  "assets/icons/$svgName",
                  width: 30,
                  height: 30,
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
