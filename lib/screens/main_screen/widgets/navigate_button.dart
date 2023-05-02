import 'package:flutter/material.dart';
import 'package:app/themes/theme_constants.dart';

class NavigateButton extends StatelessWidget {
  const NavigateButton({
    super.key,
    required this.onPress,
    this.isExpanded = false,
    this.iconData=Icons.turn_right,
  });

  final Function(bool) onPress;
  final bool isExpanded;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: Colors.white,
      child: InkWell(
        onTap: () {
          onPress(true);
        },
        splashColor: kWhiteDarker,
        highlightColor: kWhiteDarker,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: SizedBox(
          width: 55,
          height: 55,
          child: Icon(
            iconData,
            size: 40,
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}
