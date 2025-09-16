import 'package:flutter/material.dart';

import '../app_constains.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: 10,
        padding: AppConstain.ScreenPadding,

        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width - 50,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage("https://picsum.photos/200/$index"),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
