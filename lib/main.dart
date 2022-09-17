import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:marquee/marquee.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project1_ui1/Database/playlist_db.dart';
import 'package:project1_ui1/commonvariables.dart';
import 'package:project1_ui1/dbmodel/foldermodel.dart';
import 'package:project1_ui1/pages/addplaylist.dart';

import 'package:project1_ui1/pages/splash_screen.dart';
import 'package:project1_ui1/pages/front_screen.dart';
import 'package:project1_ui1/pages/front_screen2.dart';
import 'package:project1_ui1/pages/home_page.dart';

Future<void> main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(FolderModelAdapter().typeId)) {
    Hive.registerAdapter(FolderModelAdapter());
  }
  await Hive.openBox<int>('favoritedb');
  await Hive.openBox<FolderModel>(playlistdbname);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/imageee2.jpg'), context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.black,
          primarySwatch: Colors.grey,
          androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
      home: const SplashScreen(),
      builder: (context, child) {
        return Stack(
          children: [child!, CustomMiniplayer()],
        );
      },
    );
  }
}

class CustomMiniplayer extends StatefulWidget {
  const CustomMiniplayer({super.key});

  @override
  State<CustomMiniplayer> createState() => CustomMiniplayerState();
}

class CustomMiniplayerState extends State<CustomMiniplayer>
    with TickerProviderStateMixin {
  late AnimationController anicontroller;
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    anicontroller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    super.initState();
  }

  @override
  void dispose() {
    anicontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Variableclass.instance.isvisible,
      builder: (context, value, child) {
        return Visibility(
            visible: true,
            // Variableclass.instance.isvisible.value,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
              child: Miniplayer(
                elevation: 20,
                minHeight: MediaQuery.of(context).size.height * 11 / 100,
                maxHeight: 0,
                builder: (height, percentage) {
                  return Container(
                    color: Colors.grey,
                    child: Row(
                      children: [
                        AspectRatio(
                          aspectRatio: 1.6 / 1,
                          child: ShaderMask(
                            blendMode: BlendMode.dstOut,
                            shaderCallback: (rect) => const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [Colors.transparent, Colors.black])
                                .createShader(rect),
                            child: Image.asset(
                              'assets/kobu-agency-3hWg9QKl5k8-unsplash.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 115,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 30,
                                width: 140,
                                child: Marquee(
                                  text: 'name',
                                  velocity: 35,
                                  fadingEdgeStartFraction: .6,
                                  showFadingOnlyWhenScrolling: false,
                                  blankSpace: 90,
                                  pauseAfterRound:
                                      const Duration(milliseconds: 900),
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 10, 10, 10),
                                  ),
                                ),
                              ),
                              const Text(
                                'artist',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 0,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              mycolors.shufflemycolors();
                              if (Variableclass.instance.isclickedd.value) {
                                anicontroller.reverse();
                              } else {
                                anicontroller.forward();
                              }
                            });
                            Variableclass.instance.isclickedd.value =
                                !Variableclass.instance.isclickedd.value;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 133, 133, 133),
                              border: Border.all(
                                  color: const Color.fromARGB(255, 84, 84, 84)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: AnimatedIcon(
                                size: 42,
                                icon: AnimatedIcons.play_pause,
                                progress: anicontroller),
                          ),
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        Builder(builder: (context) {
                          return GestureDetector(
                            onTap: () {
                              // Navigator.of(context).push(PageTransition(
                              //   curve: Curves.easeInOutCirc,
                              //     child: HomeScreen(
                              //         songModel: Variableclass.songModel,
                              //         audioPlayer: Variableclass.audioPlayer,
                              //         songlist: Variableclass.allsonglist,

                              //         passedindex: Variableclass.passedindexx),
                              //     type: PageTransitionType.size,
                              //      alignment: Alignment.bottomCenter,
                              //   duration:
                              //       const Duration(milliseconds: 1550),
                              //   reverseDuration:
                              //       const Duration(milliseconds: 534),
                              //     ));

                              // navigatorKey.currentState?.push(MaterialPageRoute(
                              //   builder: (context) => AddPlaylist(),
                              // ));

                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AddPlaylist(),
                              ));
                            },
                            child: Container(
                                alignment: Alignment.center,
                                height: 45,
                                width: 40,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 133, 133, 133),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 84, 84, 84)),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                    size: 35, Icons.expand_less_rounded)),
                          );
                        })
                      ],
                    ),
                  );
                },
              ),
            ));
      },
    );
  }
}
