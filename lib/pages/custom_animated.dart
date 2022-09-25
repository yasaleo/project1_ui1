import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:project1_ui1/commonvariables.dart';

class ShuffleButton extends StatefulWidget {
  const ShuffleButton({super.key});

  @override
  State<ShuffleButton> createState() => _ShuffleButtonState();
}

class _ShuffleButtonState extends State<ShuffleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation scaleAnimation;

  Color shufflecolor = Colors.black;

  ValueNotifier<bool> isshuffled = ValueNotifier(false);

  double scale = 0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 30),
        reverseDuration: const Duration(milliseconds: 350),
        upperBound: .6,
        lowerBound: 0.0)
      ..addListener(() {
        isshuffled.notifyListeners();
      });
//       scaleAnimation = new Tween(
//   begin: 0.5,
//   end: 1.0,
// ).animate( CurvedAnimation(
//   parent: controller,
//   curve: Curves.bounceOut
// ));
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
                Variableclass.audioPlayer.setShuffleModeEnabled(false);
                isshuffled.notifyListeners();
                isshuffled.value = !isshuffled.value;
              } else {
                shufflecolor = Color.fromARGB(255, 13, 104, 16);
                Variableclass.audioPlayer.setShuffleModeEnabled(true);

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

class AddRemoveButton extends StatelessWidget {
  AddRemoveButton({super.key, required this.isclickedd});
  bool isclickedd;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 600),
      child: isclickedd
          ? Icon(
              Icons.remove_circle_outline_outlined,
              color: Color.fromARGB(255, 176, 12, 0),
              key: UniqueKey(),
              size: 32,
            )
          : Icon(
              Icons.playlist_add_circle_outlined,
              key: UniqueKey(),
              color: Color.fromARGB(255, 0, 0, 0),
              size: 32,
            ),
      transitionBuilder: (child, Animation<double> animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
    );
  }
}

class LoopButton extends StatefulWidget {
  const LoopButton({super.key});

  @override
  State<LoopButton> createState() => _LoopButtonState();
}

class _LoopButtonState extends State<LoopButton>
    with SingleTickerProviderStateMixin {
  bool isrepeated = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animation = Tween<double>(begin: 0, end: 1)
        .animate(_controller.drive(CurveTween(curve: Curves.bounceOut)));
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isrepeated) {
            Variableclass.audioPlayer.setLoopMode(LoopMode.all);
            _controller.reverse();
            isrepeated = !isrepeated;
          } else {
            Variableclass.audioPlayer.setLoopMode(LoopMode.one);
            _controller.forward();
            isrepeated = !isrepeated;
          }
        });
      },
      child: RotationTransition(
        turns: _animation,
        child: AnimatedSwitcher(
            duration: Duration(milliseconds: 600),
            child: !isrepeated
                ? Icon(
                    Icons.repeat_on_outlined,
                    size: 32,
                    key: UniqueKey(),
                  )
                : Icon(
                    Icons.repeat_one_on_outlined,
                    color: Color.fromARGB(
                      255,
                      13,
                      104,
                      16,
                    ),
                    size: 32,
                    key: UniqueKey(),
                  )),
      ),
    );
  }
}
