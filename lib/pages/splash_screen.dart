import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:project1_ui1/pages/front_screen.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    gohome(context);
    super.initState();
  }

  Future gohome(context) async {
    await Future.delayed(const Duration(milliseconds: 5800));
    Navigator.of(context).pushReplacement(
      PageTransition(
        curve: Curves.easeInOutCubic,
        child: const FrontScreen(),
        childCurrent: const SplashScreen(),
        type: PageTransitionType.rightToLeftWithFade,
        alignment: Alignment.bottomCenter,
        duration: const Duration(milliseconds: 2020),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.grey,
      body: RiveAnimation.asset('assets/layers_demo(5).riv',fit: BoxFit.cover,),
    );
  }
}
