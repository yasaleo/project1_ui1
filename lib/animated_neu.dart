import 'package:flutter/material.dart';

import 'package:project1_ui1/commonvariables.dart';

class AnimatedNeumorphism extends StatefulWidget {
  const AnimatedNeumorphism({
    Key? key,
  }) : super(key: key);

  @override
  State<AnimatedNeumorphism> createState() => AnimatedNeumorphismState();
}

class AnimatedNeumorphismState extends State<AnimatedNeumorphism>
    with TickerProviderStateMixin {
  double turns = 0.0;
  bool isclicked = false;
  late AnimationController controller;
  Color coustomBlackColor = const Color.fromARGB(255, 23, 23, 23);
  Color coustomwhiteColor = Colors.grey;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
    if (Variableclass.instance.isclickedd.value) {
      setState(() => turns -= 1 / 2);
      controller.forward();
      isclicked = !isclicked;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      curve: Curves.easeInOutCubicEmphasized,
      turns: turns,
      duration: const Duration(seconds: 1),
      child: GestureDetector(
        onTap: () {
          if (isclicked) {
            Variableclass.audioPlayer.pause();
            setState(() => turns -= 1 / 2);

            controller.reverse();
          } else {
            Variableclass.audioPlayer.play();

            setState(() => turns += 1 / 2);
            controller.forward();
          }
          isclicked = !isclicked;
          Variableclass.instance.isclickedd.value =
              !Variableclass.instance.isclickedd.value;
        },
        child: AnimatedContainer(
            curve: Curves.easeOutExpo,
            duration: const Duration(seconds: 1),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: coustomwhiteColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(179, 225, 225, 225),
                    offset:
                        isclicked ? const Offset(5, 5) : const Offset(-5, -5),
                    blurRadius: 15,
                  ),
                  BoxShadow(
                    color: Colors.black54,
                    offset:
                        isclicked ? const Offset(-5, -5) : const Offset(5, 7),
                    blurRadius: 15,
                  ),
                ]),
            child: AnimatedIcon(
              icon: AnimatedIcons.play_pause,
              progress: controller,
              size: 59,
            )),
      ),
    );
  }
}
