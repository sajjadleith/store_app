import 'package:flutter/material.dart';
import 'package:store/Screen/home_screen.dart';
import 'core/app_constains.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: AppConstain.appFontFamily,
      ),
      home:Home(),
    );
  }
}
