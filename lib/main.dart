import 'package:flutter/material.dart';
import 'package:store/screens/home_screen.dart';

import 'core/app_constains.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Store App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: AppConstain.appFontFamily,
      ),
      // home: Navbarcomponents(),
      home: HomeScreen(),
    );
  }
}
