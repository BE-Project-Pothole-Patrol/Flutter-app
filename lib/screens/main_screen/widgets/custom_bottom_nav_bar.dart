import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../themes/theme_constants.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({
    super.key,
    required this.horizontalPadding,
    required this.width,
    required this.onTabTapped,
    this.height = 65,
    this.selected = 0,
  });

  final double horizontalPadding;
  final double height;
  final double width;
  final Function(int) onTabTapped;
  final int selected;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  late int _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
      height: widget.height,
      width: widget.width,
      decoration: const BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 55,
            height: 55,
            alignment: Alignment.center,
            decoration: _selected == 0
                ? const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  )
                : null,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (_selected == 1) {
                    _selected = 0;
                  }
                });
                widget.onTabTapped(0);
              },
              child: SvgPicture.asset(
                "assets/icons/report_pothole_ic.svg",
                fit: BoxFit.scaleDown,
                colorFilter: _selected == 0
                    ? const ColorFilter.mode(kPrimaryColor, BlendMode.srcIn)
                    : const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
          ),
          Container(
            width: 55,
            height: 55,
            alignment: Alignment.center,
            decoration: _selected == 1
                ? const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  )
                : null,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (_selected == 0) {
                    _selected = 1;
                  }
                });
                widget.onTabTapped(1);
              },
              child: SvgPicture.asset(
                "assets/icons/pothole_map_ic.svg",
                fit: BoxFit.scaleDown,
                colorFilter: _selected == 1
                    ? const ColorFilter.mode(kPrimaryColor, BlendMode.srcIn)
                    : const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
