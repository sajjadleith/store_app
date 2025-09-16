import 'package:flutter/material.dart';

import '../app_constains.dart';

class CategorySlider extends StatefulWidget {
  const CategorySlider({super.key});

  @override
  State<CategorySlider> createState() => _CategorySliderState();
}

class _CategorySliderState extends State<CategorySlider> {
  List categories = [
    {"name": "All", "status": true},
    {
      "name":
          "SmartphonesSmartphonesSmartphonesSmartphonesSmartphonesSmartphonesSmartphonesSmartphonesSmartphonesSmartphonesSmartphonesSmartphonesSmartphonesSmartphonesSmartphonesSmartphonesSmartphonesSmartphonesSmartphonesSmartphonesSmartphonesSmartphonesSmartphonesSmartphones",
      "status": false,
    },
    {"name": "Smartphones", "status": false},
    {"name": "Smartphones", "status": false},
    {"name": "Smartphones", "status": false},
    {"name": "Smartphones", "status": false},
    {"name": "Smartphones", "status": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: ListView.separated(
        padding: AppConstain.ScreenPadding,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) {
          return SizedBox(width: 10);
        },
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Material(
            color: categories[index]["status"] == true
                ? Colors.green
                : Colors.white,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 8, right: 8),
                decoration: BoxDecoration(
                  color: categories[index]["status"] == true
                      ? Colors.green
                      : Colors.white,
                  border: categories[index]["status"] == true
                      ? null
                      : Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  categories[index]["name"].toString(),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: categories[index]["status"] == true
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
