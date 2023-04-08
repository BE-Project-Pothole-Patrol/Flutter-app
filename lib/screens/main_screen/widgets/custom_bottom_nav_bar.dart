import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../themes/theme_constants.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({
    super.key,
    required this.horizontalPadding,
    required this.width,
    required this.onTabTapped,
    this.height = 55,
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
    debugPrint('initState called');
    _selected = widget.selected;
  }

  @override
  void didUpdateWidget(covariant CustomBottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('didUpdateWidget called');
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
          Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2.0),
            color: Colors.grey,
            blurRadius: 5.0,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 45,
            height: 45,
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
                width: 35,
                height: 35,
                fit: BoxFit.fill,
                colorFilter: _selected == 0
                    ? const ColorFilter.mode(kPrimaryColor, BlendMode.srcIn)
                    : const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
          ),
          Container(
            width: 45,
            height: 45,
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
                width: 30,
                height: 30,
                fit: BoxFit.fill,
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
