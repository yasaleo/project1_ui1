// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:like_button/like_button.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:project1_ui1/front_screen.dart';
// import 'package:project1_ui1/home_page.dart';
// import 'package:project1_ui1/my_colors.dart';
// bool isclicked = false;
//    late AnimationController _controller;


// class Nowplaying extends StatefulWidget  {
//   Function onTap;
//    Nowplaying({Key? key, required this.onTap}) : super(key: key);

//   @override
//   State<Nowplaying> createState() => _NowplayingState(customfunction: onTap);
// }

// class _NowplayingState extends State<Nowplaying>with TickerProviderStateMixin {
//    Function customfunction;
//   _NowplayingState({required this.customfunction});
  
//   @override
//   void initState() {
//     _controller = AnimationController(
//         vsync:this , duration: const Duration(milliseconds: 1000),);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//                 left: MediaQuery.of(context).size.width * 1.5 / 100,
//                 right: MediaQuery.of(context).size.width * 1.5 / 100,
//                 top: MediaQuery.of(context).size.height * 8.95 / 10,
//                 bottom: MediaQuery.of(context).size.height * .6 / 100,
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.of(context).push(
//                       PageTransition(
//                         curve: Curves.easeInSine,
//                         child: const HomeScreen(),
//                         type: PageTransitionType.size,
//                         alignment: Alignment.bottomCenter,
//                         duration: const Duration(milliseconds: 320),
//                         reverseDuration: const Duration(milliseconds: 320),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                           color: Color.fromARGB(147, 0, 0, 0),
//                           blurRadius: 3,
//                           spreadRadius: 1,
//                         )
//                       ],
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(25),
//                           topRight: Radius.circular(7),
//                           bottomRight: Radius.circular(7),
//                           bottomLeft: Radius.circular(25)),
//                       color: Color.fromARGB(250, 149, 149, 149),
//                     ),
//                     child: Row(
//                       children: [
//                         ClipRRect(
//                           borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(23),
//                               bottomLeft: Radius.circular(23)
                              
//                               ),
//                           child: AspectRatio(
//                             aspectRatio: 1.6 / 1,
//                             child: ShaderMask(
//                               blendMode: BlendMode.dstOut,
//                               shaderCallback: (rect) => const LinearGradient(
//                                   begin: Alignment.centerLeft,
//                                   end: Alignment.centerRight,
//                                   colors: [
//                                     Colors.transparent,
//                                     Colors.black
//                                   ]).createShader(rect),
//                               child: Image.asset(
//                                 'assets/artistic-album-cover-design-template-d12ef0296af80b58363dc0deef077ecc_screen.jpg',
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: const [
//                             Text(
//                               'songssss',
//                               style: TextStyle(
//                                   fontSize: 21,
//                                   fontWeight: FontWeight.bold,
//                                   color: Color.fromARGB(255, 10, 10, 10)),
//                             ),
//                             Text(
//                               'Artist 1',
//                               style: TextStyle(fontSize: 20),
//                             )
//                           ],
//                         ),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             customfunction;
//                           },
//                           child: SizedBox(
//                             child: AnimatedIcon(
//                                 size: 55,
//                                 icon: AnimatedIcons.play_pause,
//                                 progress: _controller),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 19,
//                         ),
//                         LikeButton(
//                           animationDuration: const Duration(milliseconds: 1450),
//                           bubblesSize: 70,
//                           circleSize: 50,
//                           circleColor: const CircleColor(
//                             start: Color.fromARGB(52, 10, 10, 10),
//                             end: Color.fromARGB(255, 255, 0, 0),
//                           ),
//                           bubblesColor: const BubblesColor(
//                             dotPrimaryColor: Color.fromARGB(255, 255, 22, 1),
//                             dotSecondaryColor: Color.fromARGB(255, 125, 0, 0),
//                             dotThirdColor: Color.fromARGB(255, 255, 95, 92),
//                             dotLastColor: Color.fromARGB(255, 80, 5, 0),
//                           ),
//                           likeBuilder: (isLiked) {
//                             return Icon(
//                               Icons.favorite,
//                               color: isLiked
//                                   ? const Color.fromARGB(255, 129, 9, 0)
//                                   : Colors.black,
//                               size: 33,
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//   }
// }