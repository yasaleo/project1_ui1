import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project1_ui1/pages/front_screen.dart';
import 'package:project1_ui1/pages/front_screen2.dart';
import 'package:project1_ui1/pages/home_page.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('assets/imageee2.jpg'), context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.black,
          primarySwatch: Colors.grey,
          androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
      home: const FrontScreen(),
    );
  }
}
