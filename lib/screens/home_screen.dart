import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store/Screen/custom_appbar.dart';
import 'package:store/core/app_constains.dart';

import '../core/app_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: CustomAppbar()),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[300],
                    labelText: "Search",
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
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  itemCount: 10,
                  padding: AppConstain.ScreenPadding,

                  itemBuilder: (context, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width - 50,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://picsum.photos/200/$index",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Categories",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "See all",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: AppConstain.ScreenPadding,
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: ListView.separated(
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
              ),
            ),
            // SliverGrid.builder(delegate: delegate, gridDelegate: gridDelegate),
          ],
        ),
      ),
    );
  }
}
