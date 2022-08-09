import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project1_ui1/listcard.dart';
import 'package:project1_ui1/playlist_card.dart';
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
              PreferredSize(
                preferredSize: const Size.fromHeight(180),
                child: SliverAppBar(
                  pinned: true,
                  collapsedHeight: 75,
                  elevation: 0,
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  leading: const Icon(
                    Icons.menu_rounded,
                    color: Colors.black,
                    size: 37,
                  ),
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
                                          color:
                                              Color.fromARGB(185, 19, 19, 19),
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
                                        color: Colors.black38, fontSize: 40),
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
                                duration: const Duration(milliseconds: 2300),
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
                                  mycolors.shufflemycolors();
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
                      height: 200,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 540,
                      child: ListView.builder(
                        itemBuilder:(context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                            child: ListCard()
                          );
                        }, 
                        itemCount: 10,
                        ),
                    ),
                    
                  ],
                ),
                
              ),
              
            ],
            
          ),
        ),
      ),
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
