import 'package:flutter/material.dart';

class AnimatedNeumorphism extends StatefulWidget {
  const AnimatedNeumorphism({Key? key}) : super(key: key);

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
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    super.initState();
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
            setState(() => turns -= 1 / 2);
            _controller.reverse();
          } else {
            setState(() => turns += 1 / 2);
            _controller.forward();
          }
          isclicked = !isclicked;
        },
        child: AnimatedContainer(
          curve: Curves.easeOutExpo,
          duration: Duration(seconds: 1),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: coustomwhiteColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow:  [
                BoxShadow(
                  color: Color.fromARGB(179, 225, 225, 225),
                  offset: isclicked
                  ?Offset(5, 5)
                  :Offset(-5, -5),
                  blurRadius: 15,
                ),
                BoxShadow(
                  color: Colors.black54,
                  offset: isclicked?Offset(-5, -5) : Offset(5, 7),
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
