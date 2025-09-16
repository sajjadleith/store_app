import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/app_icons.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Discover", style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20
          ),),
          IconButton(
            onPressed: () {},
            icon: Badge.count(count: 99,child: SvgPicture.asset(AppIcons.cartIcon
              ,),),
          )
        ],
      ),
    );
  }
}
