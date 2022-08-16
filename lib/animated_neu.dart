import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:project1_ui1/commonvariables.dart';
import 'package:project1_ui1/front_screen.dart';

class AnimatedNeumorphism extends StatefulWidget {
  final AudioPlayer audioPlayer;
  //  bool isclickedd;
   AnimatedNeumorphism({Key? key,required this.audioPlayer}) : super(key: key);

  @override
  State<AnimatedNeumorphism> createState() => _AnimatedNeumorphismState();
}

class _AnimatedNeumorphismState extends State<AnimatedNeumorphism>
    with TickerProviderStateMixin {
  double turns = 0.0;
  bool isclicked = false;
  late AnimationController _controller;
  Color coustomBlackColor = const Color.fromARGB(255, 23, 23, 23);
  Color coustomwhiteColor = Colors.grey;

  @override
  void initState() {
    _controller =
        AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    super.initState();
    if (Variableclass.instance.isclickedd.value) {
            setState(() => turns -= 1 / 2);
            _controller.forward();
            isclicked = !isclicked;
          } 
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      curve: Curves.easeOutExpo,
      turns: turns,
      duration: const Duration(seconds: 1),
      child: GestureDetector(
        onTap: () {
          if (isclicked) {
            widget.audioPlayer.pause();
            setState(() => turns -= 1 / 2);
            
            _controller.reverse();
          } else {
            widget.audioPlayer.play();

            setState(() => turns += 1 / 2);
            _controller.forward();
          }
          isclicked = !isclicked;
          Variableclass.instance.isclickedd.value=!Variableclass.instance.isclickedd.value;

        },
        child: AnimatedContainer(
          curve: Curves.easeOutExpo,
          duration: const Duration(seconds: 1),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: coustomwhiteColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow:  [
                BoxShadow(
                  color: const Color.fromARGB(179, 225, 225, 225),
                  offset: isclicked
                  ?const Offset(5, 5)
                  :const Offset(-5, -5),
                  blurRadius: 15,
                ),
                BoxShadow(
                  color: Colors.black54,
                  offset: isclicked?const Offset(-5, -5) : const Offset(5, 7),
                  blurRadius: 15,
                ),
              ]),
          child: AnimatedIcon(
            icon: AnimatedIcons.play_pause, 
            progress: _controller,
            size: 59,
            )
        ),
      ),
    );
  }
}
