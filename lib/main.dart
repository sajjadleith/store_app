import 'package:flutter/material.dart';
import 'package:store/screens/custom_navbar.dart';
import 'package:store/screens/dummy_screen.dart';
import 'package:store/screens/home_screen.dart';

import 'core/app_constains.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;

  final List<Widget> screens = [HomeScreen(), DummyScreen()];

  onChange(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Store App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: AppConstain.appFontFamily,
      ),
      // home: Navbarcomponents(),
      home: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: CustomNavbar(
          currentIndex: currentIndex,
          onChange: onChange,
        ),
      ),
    );
  }
}
