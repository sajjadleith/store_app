import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavbarIconCustom extends StatelessWidget {
  const NavbarIconCustom({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    required this.color,
  });

  final String icon;
  final String text;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            Text(text, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }
}
