import 'package:flutter/material.dart';
import 'package:store/core/app_constains.dart';

class CustomButtonWidget extends StatefulWidget {
  const CustomButtonWidget({super.key, required this.title, required this.onPressed});
  final String title;
  final VoidCallback onPressed;

  @override
  _CustomButtonWidgetState createState() => _CustomButtonWidgetState();
}

class _CustomButtonWidgetState extends State<CustomButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppConstain.primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: widget.onPressed,
      child: Text(
        widget.title,
        style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700, color: Colors.white),
      ),
    );
  }
}
