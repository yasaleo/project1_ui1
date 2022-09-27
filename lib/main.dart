// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';



import 'package:project1_ui1/Database/playlist_db.dart';

import 'package:project1_ui1/dbmodel/foldermodel.dart';


import 'package:project1_ui1/pages/splash_screen.dart';



Future<void> main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(FolderModelAdapter().typeId)) {
    Hive.registerAdapter(FolderModelAdapter());
  }
  await Hive.openBox<int>('favoritedb');
  await Hive.openBox<FolderModel>(playlistdbname);



  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
      SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/imageee2.jpg'), context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.black,
          primarySwatch: Colors.grey,
          androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
      home: const SplashScreen(),
    
    );
  }
}

