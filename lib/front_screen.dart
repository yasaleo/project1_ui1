import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project1_ui1/listcard.dart';
import 'package:project1_ui1/navigation_drawer_widget.dart';
import 'package:project1_ui1/playlist_card.dart';
import 'package:project1_ui1/my_colors.dart';

import 'home_page.dart';

final mycolors = MyColors();

class FrontScreen extends StatefulWidget {
  const FrontScreen({Key? key}) : super(key: key);

  @override
  State<FrontScreen> createState() => _FrontScreenState();
}

class _FrontScreenState extends State<FrontScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  bool isclicked = false;
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 550),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: isclicked
            ? Color.fromARGB(
                255, mycolors.color1, mycolors.color2, mycolors.color3)
            : Colors.grey,
        child: CustomPaint(
          painter: LinePainter(),
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  PreferredSize(
                    preferredSize: const Size.fromHeight(180),
                    child: SliverAppBar(
                      pinned: true,
                      collapsedHeight:
                          MediaQuery.of(context).size.height * 9.2 / 100,
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
                          height: 70,
                          width: 94.5,
                          child: Center(
                            child: AnimatedTextKit(
                              animatedTexts: [
                                RotateAnimatedText('Musify',
                                    textStyle: GoogleFonts.k2d(
                                      textStyle: const TextStyle(
                                          shadows: [
                                            Shadow(
                                                color: Colors.black45,
                                                offset: Offset(2, 3),
                                                blurRadius: 8)
                                          ],
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
                        const SizedBox(
                          height: 20,
                        ),
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
                                  onPressed: () {},
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
                          height: 165,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return const Padding(
                                padding: EdgeInsets.only(
                                    top: 10, right: 10, left: 10),
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 1 / 1.8,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(bottom: 90),
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
                left: MediaQuery.of(context).size.width * 1.5 / 100,
                right: MediaQuery.of(context).size.width * 1.5 / 100,
                top: MediaQuery.of(context).size.height * 8.95 / 10,
                bottom: MediaQuery.of(context).size.height * .6 / 100,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageTransition(
                        curve: Curves.easeInSine,
                        child: const HomeScreen(),
                        type: PageTransitionType.size,
                        alignment: Alignment.bottomCenter,
                        duration: const Duration(milliseconds: 320),
                        reverseDuration: const Duration(milliseconds: 320),
                      ),
                    );
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(147, 0, 0, 0),
                            blurRadius: 12,
                            spreadRadius: 3)
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(7),
                          bottomLeft: Radius.circular(7)),
                      color: Color.fromARGB(250, 149, 149, 149),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(5)),
                          child: AspectRatio(
                            aspectRatio: 1.6 / 1,
                            child: ShaderMask(
                              blendMode: BlendMode.dstOut,
                              shaderCallback: (rect) => const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black
                                  ]).createShader(rect),
                              child: Image.asset(
                                'assets/artistic-album-cover-design-template-d12ef0296af80b58363dc0deef077ecc_screen.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Text(
                              'songssss',
                              style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 10, 10, 10)),
                            ),
                            Text(
                              'Artist 1',
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                mycolors.shufflemycolors();

                                if (isclicked) {
                                  _controller.reverse();
                                } else {
                                  _controller.forward();
                                }
                              },
                            );
                            isclicked = !isclicked;
                          },
                          child: SizedBox(
                            child: AnimatedIcon(
                                size: 55,
                                icon: AnimatedIcons.play_pause,
                                progress: _controller),
                          ),
                        ),
                        const SizedBox(
                          width: 19,
                        ),
                        LikeButton(
                          animationDuration: const Duration(milliseconds: 1450),
                          bubblesSize: 70,
                          circleSize: 50,
                          circleColor: const CircleColor(
                            start: Color.fromARGB(52, 10, 10, 10),
                            end: Color.fromARGB(255, 255, 0, 0),
                          ),
                          bubblesColor: const BubblesColor(
                            dotPrimaryColor: Color.fromARGB(255, 255, 22, 1),
                            dotSecondaryColor: Color.fromARGB(255, 125, 0, 0),
                            dotThirdColor: Color.fromARGB(255, 255, 95, 92),
                            dotLastColor: Color.fromARGB(255, 80, 5, 0),
                          ),
                          likeBuilder: (isLiked) {
                            return Icon(
                              Icons.favorite,
                              color: isLiked
                                  ? const Color.fromARGB(255, 129, 9, 0)
                                  : Colors.black,
                              size: 33,
                            );
                          },
                        ),
                      ],
                    ),
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
