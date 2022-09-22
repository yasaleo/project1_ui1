import 'package:flutter/material.dart';

class ShuffleButton extends StatefulWidget {
  const ShuffleButton({super.key});

  @override
  State<ShuffleButton> createState() => _ShuffleButtonState();
}

class _ShuffleButtonState extends State<ShuffleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  Color shufflecolor = Colors.black;

  ValueNotifier<bool> isshuffled = ValueNotifier(false);

  double scale = 0;


  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 110),
        reverseDuration: const Duration(milliseconds: 350),
        upperBound: .6,
        lowerBound: 0.0)
      ..addListener(() {
        isshuffled.notifyListeners();
      });

  }

  void _ontapup(TapUpDetails details) {
    controller.reverse();
  }

  void _ontapdown(TapDownDetails details) {
    controller.forward();
  }

  void _ontapcancel() {
    controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isshuffled,
        builder: (context, value, Widget? _) {
          scale = 1.2 + controller.value;
          return GestureDetector(
            onTapUp: _ontapup,
            onTapDown: _ontapdown,
            onTapCancel: _ontapcancel,
            onTap: () {
              if (isshuffled.value) {
                shufflecolor = Colors.black;
                isshuffled.notifyListeners();
                isshuffled.value = !isshuffled.value;
              } else {
                shufflecolor = Color.fromARGB(255, 13, 104, 16);
                isshuffled.notifyListeners();

                isshuffled.value = !isshuffled.value;
              }
            },
            child: Transform.scale(
              scale: scale,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: Icon(
                  Icons.shuffle_on_outlined,
                  key: UniqueKey(),
                  color: shufflecolor,
                  size: 27,
                ),
              ),
            ),
          );
        });
  }
}
