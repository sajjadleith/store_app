import 'package:flutter/material.dart';
import 'package:store/core/app_icons.dart';
import 'package:store/screens/dummy_screen.dart';
import 'package:store/screens/home_screen.dart';

import '../core/widgets/navbar_icon_custom.dart';

class CustomNavbar extends StatefulWidget {
  const CustomNavbar({super.key});

  @override
  State<CustomNavbar> createState() => _CustomNavbarState();
}

class _CustomNavbarState extends State<CustomNavbar> {
  int currentIndex = 0;
  List<Widget> screens = [HomeScreen(), DummyScreen()];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          NavbarIconCustom(icon: AppIcons.home, text: "Home", onTap: () {}),
          NavbarIconCustom(icon: AppIcons.search, text: "Search", onTap: () {}),
          NavbarIconCustom(icon: AppIcons.fav, text: "Favorite", onTap: () {}),
          NavbarIconCustom(
            icon: AppIcons.profile,
            text: "Profile",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
