import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavbarIconCustom extends StatelessWidget {
  const NavbarIconCustom({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final String icon;
  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [SvgPicture.asset(icon), Text(text)],
        ),
      ),
    );
  }
}
