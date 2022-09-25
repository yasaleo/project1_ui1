import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import 'package:project1_ui1/pages/front_screen.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animate = false;
  @override
  void initState() {
    startanimation();
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
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Stack(
          children: [
            AnimatedPositioned(
              curve: Curves.elasticOut,
              duration: const Duration(milliseconds: 2600),
              top: 40,
              left: animate ? 50 : -600,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 2020),
                opacity: animate ? 1 : 0,
                child: Text(
                  'Musify',
                  style: GoogleFonts.k2d(
                    textStyle: const TextStyle(
                        shadows: [
                          Shadow(
                              color: Colors.black45,
                              offset: Offset(2, 3),
                              blurRadius: 8)
                        ],
                        color: Colors.black,
                        fontSize: 93,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 1100),
              opacity: animate ? 1 : 0,
              child: const RiveAnimation.asset(
                'assets/layers_demo(5).riv',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future startanimation() async {
    await Future.delayed(const Duration(milliseconds: 10));
    setState(() {
      animate = true;
    });
  }
}
