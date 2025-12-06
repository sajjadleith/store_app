import 'package:flutter/material.dart';
import 'package:store/core/app_constains.dart';
import 'package:store/screens/widgets/slider_widget.dart';

import '../core/widgets/category_slider.dart';
import '../core/widgets/slider_widget.dart';
import '../core/widgets/sliver_grid_widget.dart';
import '../core/widgets/text_field_widget.dart';
import 'custom_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: CustomAppbarWidget(title: "Home")),

            // SliverToBoxAdapter(child: TextFieldWidget()),
            SliverToBoxAdapter(child: SizedBox(height: 30)),
            // SliverToBoxAdapter(child: SliderWidget()),
            SliverToBoxAdapter(child: SliderWidget2()),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Categories", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "See all",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppConstain.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(child: CategorySlider()),
            SliverToBoxAdapter(child: const SizedBox(height: 20)),
            SliverGridWidget(),
          ],
        ),
      ),
    );
  }
}
