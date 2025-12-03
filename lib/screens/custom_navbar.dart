import 'package:flutter/material.dart';
import 'package:store/core/app_constains.dart';
import 'package:store/core/app_icons.dart';

import '../core/widgets/navbar_icon_custom.dart';

class CustomNavbar extends StatelessWidget {
  const CustomNavbar({
    super.key,
    required this.currentIndex,
    required this.onChange,
  });

  final int currentIndex;
  final Function(int) onChange;

  // onChange(int index) {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 70,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            NavbarIconCustom(
              icon: AppIcons.home,
              text: "Home",
              onTap: () => onChange(0),
              color: currentIndex == 0 ? AppConstain.primaryColor : Colors.black,
            ),
            NavbarIconCustom(
              icon: AppIcons.search,
              text: "Search",
              onTap: () => onChange(1),
              color: currentIndex == 1 ? AppConstain.primaryColor : Colors.black,
            ),
            NavbarIconCustom(
              icon: AppIcons.fav,
              text: "Favorite",
              onTap: () => onChange(2),
              color: currentIndex == 2 ? AppConstain.primaryColor : Colors.black,
            ),
            NavbarIconCustom(
              icon: AppIcons.profile,
              text: "Profile",
              onTap: () => onChange(3),
              color: currentIndex == 3 ? AppConstain.primaryColor : Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
