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
      body: AnimatedContainer(
          duration: const Duration(milliseconds: 550),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color.fromARGB(
              255, mycolors.color1, mycolors.color2, mycolors.color3),
          child: CustomPaint(
            painter: LinePainter(),
            child: CustomScrollView(
              slivers: [
                 SliverAppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: const Icon(Icons.menu),
                  expandedHeight: 300,
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: [],
                    background: Container(
                      color: Colors.black12,
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 190,top: 40),
                          child: Column(
                            
                            
                            children: const [
                              Text('  Heal',style: TextStyle(color: Colors.white,fontSize: 60),),
                              Text('   yourself ',style: TextStyle(color: Colors.white,fontSize: 50),),
                              Text('with',style: TextStyle(color: Colors.white,fontSize: 50),),
                      
                            ],
                          ),
                        ),
                      ),
                    ),
                    title: const Text('m u s i c',style: TextStyle(color: Colors.white,fontSize: 30)),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            mycolors.shufflemycolors();
                          });
                        },
                        child: const Text('Shuffle'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green 
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        },
                        child: const Text(' Home '),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          width: 400,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          width: 400,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          width: 400,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          width: 400,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          width: 400,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          width: 400,
                          color: Colors.black,
                        ),
                      ),Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          width: 400,
                          color: Colors.black,
                        ),
                      ),Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          width: 400,
                          color: Colors.black,
                        ),
                      ),Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          width: 400,
                          color: Colors.black,
                        ),
                      ),Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          width: 400,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          width: 400,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          width: 400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..color = Colors.grey;
    // Color.fromARGB(255, mycolors.color1, mycolors.color2, mycolors.color3);

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
