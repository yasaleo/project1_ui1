import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:project1_ui1/pages/splash_screen.dart';
import 'package:project1_ui1/pages/front_screen.dart';
import 'package:project1_ui1/pages/front_screen2.dart';
import 'package:project1_ui1/pages/home_page.dart';

Future<void> main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<int>('favoritedb');
  // if (!Hive.isAdapterRegistered(FavoritesModelAdapter().typeId)) {
  //   Hive.registerAdapter(FavoritesModelAdapter());
  // }
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
      home: const SplashScreen(),
    );
  }
}
