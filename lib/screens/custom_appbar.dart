import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/app_icons.dart';

class CustomAppbarWidget extends StatelessWidget {
  const CustomAppbarWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
          IconButton(
            onPressed: () {},
            icon: Badge.count(count: 99, child: SvgPicture.asset(AppIcons.cartIcon)),
          ),
        ],
      ),
    );
  }
}
