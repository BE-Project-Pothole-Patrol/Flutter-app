import 'package:flutter/material.dart';
import 'package:app/themes/theme_constants.dart';

class NavigateButton extends StatelessWidget {
  const NavigateButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: Colors.white,
      child: InkWell(
        onTap: (){},
        splashColor: kWhiteDarker,
        highlightColor: kWhiteDarker,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: const SizedBox(
          width: 55,
          height: 55,
          child: Icon(
            Icons.turn_right,
            size: 40,
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}