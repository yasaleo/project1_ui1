import 'package:flutter/material.dart';

class NeumorphicWidget extends StatefulWidget {
  const NeumorphicWidget({Key? key, required this.child}) : super(key: key);
  final Widget child;
  

  @override
  State<NeumorphicWidget> createState() => _NeumorphicWidgetState();
}

class _NeumorphicWidgetState extends State<NeumorphicWidget> {
  bool _iselevated = true;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: (_) => setState(() => _iselevated = true),
      onPointerDown: (_) => setState(() => _iselevated = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 110),
        curve: Curves.easeInOutSine,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20),
            boxShadow: _iselevated
                ? [
                    const BoxShadow(
                      color: Color.fromARGB(179, 225, 225, 225),
                      offset: Offset(-7, -5),
                      blurRadius: 15,
                    ),
                    const BoxShadow(
                      color: Colors.black54,
                      offset: Offset(5, 7),
                      blurRadius: 15,
                    ),
                  ]
                : null),
        child: widget.child,
      ),
    );
  }
}

class NormalNeumorphism extends StatelessWidget {
 const  NormalNeumorphism({Key? key, required this.child,required this.height,required this.width}) : super(key: key);
  final Widget child;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height:height ,
      width: width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(179, 225, 225, 225),
            offset: Offset(-7, -5),
            blurRadius: 15,
          ),
          BoxShadow(
            color: Colors.black54,
            offset: Offset(5, 7),
            blurRadius: 15,
          ),
        ],
      ),
      child: child,
    );
  }
}
