import 'package:flutter/material.dart';
import 'package:store/screens/dummy_screen.dart';
import 'package:store/screens/home_screen.dart';

import '../core/app_icons.dart';
import '../core/widgets/navigation_widget.dart';

class Navbarcomponents extends StatefulWidget {
  const Navbarcomponents({super.key});

  @override
  State<Navbarcomponents> createState() => _NavbarcomponentsState();
}

class _NavbarcomponentsState extends State<Navbarcomponents> {
  int currentIndex = 0;
  List<Widget> screens = [HomeScreen(), DummyScreen()];
  Color currentColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationWidget(
            label: 'Home',
            icon: AppIcons.home,
            navIndex: 0,
            currentIndex: currentIndex,
          ),
          NavigationWidget(
            label: 'Search',
            icon: AppIcons.search,
            navIndex: 1,
            currentIndex: currentIndex,
          ),
          NavigationWidget(
            label: 'Favorite',
            icon: AppIcons.fav,
            navIndex: 2,
            currentIndex: currentIndex,
          ),
          NavigationWidget(
            label: 'Profile',
            icon: AppIcons.profile,
            navIndex: 3,
            currentIndex: currentIndex,
          ),
        ],
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          currentIndex = index;
          screens[currentIndex] = screens[index];
          currentColor = Colors.green;
          setState(() {});
        },
      ),
    );
  }
}
