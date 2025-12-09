import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/app_constains.dart';
import '../../core/app_icons.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onPressed, required, required this.title});
  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppConstain.primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700, color: Colors.white),
          ),
          SizedBox(width: 10),
          SvgPicture.asset(AppIcons.forwardArrow),
        ],
      ),
    );
  }
}
