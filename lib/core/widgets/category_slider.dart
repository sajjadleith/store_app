import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/controllers/book_provider.dart';
import 'package:store/controllers/category_provider.dart';
import 'package:store/core/enums/request_state.dart';
import 'package:store/model/categories_model.dart';

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
  void initState() {
    Future.microtask(() {
      context.read<CategoryProvider>().getDataCategory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child) {
        switch (categoryProvider.generalState.requestState) {
          case RequestState.loading:
            return Center(child: CircularProgressIndicator());
          case RequestState.success:
            final List<CategoriesModel> data = categoryProvider.generalState.data;
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: ListView.separated(
                padding: AppConstain.ScreenPadding,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return SizedBox(width: 10);
                },
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final isSelected = categoryProvider.selectedIndex == index;
                  final item = data[index];
                  return Material(
                    color: isSelected ? AppConstain.primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        categoryProvider.selectCategor(index);
                        context.read<BookProvider>().filterByCategory(item.name);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 8, right: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? AppConstain.primaryColor : Colors.white,
                          border: isSelected ? null : Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          item.name.toString(),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          case RequestState.error:
            return Center(child: Text("An error ${RequestState.error}"));
          case RequestState.empty:
            return Center(child: Text("no data"));
        }
      },
    );
  }
}
