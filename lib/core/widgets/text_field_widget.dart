import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../app_icons.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[300],
          hint: Text("Search"),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide.none,
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(AppIcons.search),
          ),
        ),
      ),
    );
  }
}
