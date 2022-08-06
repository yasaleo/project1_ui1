import 'package:flutter/material.dart';
import 'package:project1_ui1/home_page.dart';
import 'package:project1_ui1/my_colors.dart';

final mycolors = MyColors();

class FrontScreen extends StatefulWidget {
  const FrontScreen({Key? key}) : super(key: key);

  @override
  State<FrontScreen> createState() => _FrontScreenState();
}

class _FrontScreenState extends State<FrontScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey,
        // child: TweenAnimationBuilder(
        //   duration: Duration(seconds: 3),
        //   tween: ColorTween(begin: Colors.grey,end: Color.fromARGB(255, mycolors.color1, mycolors.color2, mycolors.color3)),
        //   builder: (context, Color, child) {
        //     return  CustomPaint(
        //     painter: LinePainter(colorss: value),
        //     child: SafeArea(
        //       child: Column(
        //         children: [
        //           const Text(
        //             'bello0000000',
        //             style: TextStyle(
        //                 color: Color.fromARGB(255, 0, 95, 3),
        //                 fontSize: 50,
        //                 fontWeight: FontWeight.w700),
        //           ),
        //           ElevatedButton.icon(
        //             onPressed: (){
        //               setState(() {
        //                 mycolors.shufflemycolors();
        //                 print(mycolors.color1);
        //               });
        //             },
        //             icon: const Icon(Icons.shuffle_rounded),
        //             label: const Text('Shuffle'))
        //         ],
        //       ),
        //     ),
        //   );
        //   },
        child: CustomPaint(
          painter: LinePainter(),
          child: SafeArea(
            child: Column(
              children: [
                const Text(
                  'bello0000000',
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 95, 3),
                      fontSize: 50,
                      fontWeight: FontWeight.w700),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      mycolors.shufflemycolors();
                    });
                  },
                  icon: const Icon(Icons.shuffle_rounded),
                  label: const Text('Shuffle'),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    },
                    icon: Icon(Icons.navigate_next_sharp))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  // final Color colorss;

  // LinePainter({required this.colorss});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..color = Color.fromARGB(
          255, mycolors.color1, mycolors.color2, mycolors.color3);

    canvas.drawLine(Offset(size.width * 0, size.height * 0),
        Offset(size.width * 7 / 20, size.height * 7 / 20), paint);

    final a = Offset(size.width * -1, size.height * 4 / 5);
    final b = Offset(size.width * 4 / 10, size.height * 1);

    final rect = Rect.fromPoints(a, b);

    canvas.drawRect(rect, paint);

    const radius = Radius.circular(20);

    final c = Offset(size.width * 1 / 2, size.height * 3 / 10);
    final d = Offset(size.width * 1.5, size.height * 3 / 5);

    final rrect = Rect.fromPoints(c, d);

    canvas.drawRRect(RRect.fromRectAndRadius(rrect, radius), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
