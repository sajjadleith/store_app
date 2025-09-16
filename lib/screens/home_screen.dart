import 'package:flutter/material.dart';
import 'package:store/screens/dummy_screen.dart';

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
  int currentIndex = 0;
  List screens = [HomeScreen(), DummyScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: CustomAppbarWidget()),
            SliverToBoxAdapter(child: TextFieldWidget()),

            SliverToBoxAdapter(child: SliderWidget()),
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
            SliverToBoxAdapter(child: CategorySlider()),
            SliverToBoxAdapter(child: const SizedBox(height: 20)),
            SliverGridWidget(),
          ],
        ),
      ),
    );
  }
}
