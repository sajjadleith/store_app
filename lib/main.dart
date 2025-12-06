import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/controllers/book_provider.dart';
import 'package:store/controllers/carousel_provider.dart';
import 'package:store/controllers/category_provider.dart';
import 'package:store/controllers/comment_provider.dart';
import 'package:store/controllers/login_provider.dart';
import 'package:store/controllers/rating_provider.dart';
import 'package:store/controllers/register_provider.dart';
import 'package:store/core/services/shared_pref_service.dart';
import 'package:store/screens/custom_navbar.dart';
import 'package:store/screens/dummy_screen.dart';
import 'package:store/screens/home_screen.dart';
import 'package:store/screens/register_screen.dart';

import 'controllers/details_provider.dart';
import 'core/app_constains.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefServcie.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BookProvider()),
        ChangeNotifierProvider(create: (context) => DetailsProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => RegisterProvider()),
        ChangeNotifierProvider(create: (context) => CommentProvider()),
        ChangeNotifierProvider(create: (context) => RatingProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => CarouselProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Store App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          fontFamily: AppConstain.appFontFamily,
        ),
        // home: Navbarcomponents(),
        home: Scaffold(
          body: screens[currentIndex],
          bottomNavigationBar: CustomNavbar(currentIndex: currentIndex, onChange: onChange),
        ),
        // home: RegisterScreen(),
      ),
    );
  }
}
