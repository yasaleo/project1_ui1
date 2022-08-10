import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project1_ui1/home_page.dart';
import 'package:project1_ui1/listcard.dart';
import 'package:project1_ui1/navigation_drawer_widget.dart';

import 'playlist_card.dart';

// final mycolors = MyColors();

class FrontScreen2 extends StatefulWidget {
  const FrontScreen2({Key? key}) : super(key: key);

  @override
  State<FrontScreen2> createState() => _FrontScreenState();
}

class _FrontScreenState extends State<FrontScreen2>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 550),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey,
        child: CustomPaint(
          painter: LinePainter(colorss: Colors.grey),
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  PreferredSize(
                    preferredSize: const Size.fromHeight(180),
                    child: SliverAppBar(
                      pinned: true,
                      collapsedHeight:
                          MediaQuery.of(context).size.height * 2 / 25,
                      elevation: 0,
                      centerTitle: true,
                      backgroundColor: Colors.transparent,
                      
                      expandedHeight: 314,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        background: Container(
                          color: Colors.transparent,
                          child: SafeArea(
                            child: Column(
                              children: [
                                SingleChildScrollView(
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 60,
                                      ),
                                      Text('O',
                                          style: GoogleFonts.capriola(
                                            textStyle: const TextStyle(
                                              color: Color.fromARGB(
                                                  185, 19, 19, 19),
                                              fontSize: 80,
                                            ),
                                          )),
                                      Text('utburst',
                                          style: GoogleFonts.capriola(
                                            textStyle: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 54,
                                                fontWeight: FontWeight.w500),
                                          )),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 21),
                                  child: Text('your soul ',
                                      style: GoogleFonts.capriola(
                                        textStyle: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 47,
                                            fontWeight: FontWeight.w400),
                                      )),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 164),
                                  child: Text('with',
                                      style: GoogleFonts.capriola(
                                        textStyle: const TextStyle(
                                            color: Colors.black38,
                                            fontSize: 40),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                        title: SizedBox(
                          height: 50,
                          width: 94.5,
                          child: Center(
                            child: AnimatedTextKit(
                              animatedTexts: [
                                RotateAnimatedText('Musify',
                                    textStyle: GoogleFonts.k2d(
                                      textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    duration:
                                        const Duration(milliseconds: 1300),
                                    alignment: Alignment.centerLeft,
                                    rotateOut: false)
                              ],
                              isRepeatingAnimation: false,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                " Your playlist",
                                style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 30,
                                width: 65,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      primary: Colors.black12,
                                      elevation: 0),
                                  onPressed: () {
                                    setState(() {
                                      // mycolors.shufflemycolors();
                                    });
                                  },
                                  child: const Text(
                                    'more',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 175,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: PlaylistCard(),
                              );
                            },
                            itemCount: 10,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 250, top: 20),
                          child: Text(
                            'Audio files',
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 60),
                          child: Divider(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 1 / 1.8,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return const Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, bottom: 10),
                                  child: ListCard());
                            },
                            itemCount: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 1 / 50,
                right: MediaQuery.of(context).size.width * 1 / 50,
                top: MediaQuery.of(context).size.height * 9 / 10,
                bottom: MediaQuery.of(context).size.height * 1 / 60,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageTransition(
                          child: const HomeScreen(),
                          type: PageTransitionType.size,
                          alignment: Alignment.bottomCenter,
                          duration: const Duration(milliseconds: 320),
                          reverseDuration: const Duration(milliseconds: 320)
                          
                          ),
                          
                    );
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.red,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  final Color colorss;

  LinePainter({required this.colorss});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..color = colorss;
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
