import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavigationWidget extends StatelessWidget {
  const NavigationWidget({
    required this.label,
    required this.icon,
    required this.navIndex,
    required this.currentIndex,
  });

  final String label;
  final String icon;
  final int currentIndex;
  final int navIndex;

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(
          currentIndex == navIndex ? Colors.green : Colors.black,
          BlendMode.srcIn,
        ),
      ),
      label: label,
    );
  }
}
