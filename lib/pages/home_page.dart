import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:project1_ui1/animated_neu.dart';
import 'package:project1_ui1/neumorphism.dart';
import 'package:project1_ui1/pages/custom_animated.dart';

import '../Database/favoritesdb.dart';
import '../commonvariables.dart';
import 'package:rxdart/rxdart.dart';

class HomeScreen extends StatefulWidget {
  final List<SongModel> songlist;
  

const  HomeScreen({
    Key? key,
    required this.songlist,
 
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final Duration duration = const Duration();
  final Duration position = const Duration();
  late int currentIndex;

  @override
  void initState() {
    Variableclass.audioPlayer.currentIndexStream.listen((index) {
      if (index != null && mounted) {
        setState(() {
          Variableclass.instance.miniindex.value = index;
          currentIndex = index;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: NeumorphicWidget(
                      child: Transform.rotate(
                        angle: 4.7,
                        child: const Icon(size: 38, Icons.arrow_back_ios_new),
                      ),
                    ),
                  ),
                  const Text(
                    'Now Playing',
                    style: TextStyle(
                        fontSize: 25,
                        letterSpacing: 4.5,
                        fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () {

                    },
                    child: const NeumorphicWidget(
                      child: Icon(
                        Icons.playlist_add_sharp,
                        size: 38,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 40),
              NormalNeumorphism(
                height: 340,
                width: 400,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: AspectRatio(
                        aspectRatio: 1.5 / 1,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 1000),
                          child: QueryArtworkWidget(
                            artworkWidth: 340,
                            artworkHeight: 249,
                            key: UniqueKey(),
                            format: ArtworkFormat.JPEG,
                            artworkFit: BoxFit.fill,
                            artworkBorder: BorderRadius.circular(10),
                            id: widget.songlist[currentIndex].id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: const Icon(
                              Icons.music_note_outlined,
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      height: 26,
                      thickness: 1.7,
                      color: Colors.black12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 30,
                                width: 200,
                                child: Marquee(
                                  showFadingOnlyWhenScrolling: false,
                                  fadingEdgeStartFraction: .2,
                                  fadingEdgeEndFraction: .17,
                                  text: widget
                                      .songlist[currentIndex].displayNameWOExt,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                  blankSpace: 90,
                                  velocity: 35,
                                  pauseAfterRound:
                                      const Duration(milliseconds: 900),
                                ),
                              ),
                              const Divider(
                                height: 10,
                              ),
                              SizedBox(
                                height: 30,
                                width: 190,
                                child: Text(
                                  widget.songlist[currentIndex].artist
                                              .toString() ==
                                          "<unknown>"
                                      ? 'Unknown Artist'
                                      : widget.songlist[currentIndex].artist
                                          .toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                              )
                            ],
                          ),
                          LikeButton(
                            animationDuration:
                                const Duration(milliseconds: 1450),
                            bubblesSize: 70,
                            circleSize: 50,
                            circleColor: const CircleColor(
                              start: Color.fromARGB(255, 10, 10, 10),
                              end: Color.fromARGB(255, 255, 0, 0),
                            ),
                            bubblesColor: const BubblesColor(
                              dotPrimaryColor: Color.fromARGB(255, 255, 22, 1),
                              dotSecondaryColor: Color.fromARGB(255, 125, 0, 0),
                              dotThirdColor: Color.fromARGB(255, 255, 95, 92),
                              dotLastColor: Color.fromARGB(255, 80, 5, 0),
                            ),
                            likeBuilder: (isLiked) {
                              return FavoritesDB.isfavorite(
                                      widget.songlist[currentIndex])
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Color.fromARGB(255, 129, 9, 0),
                                      size: 32,
                                    )
                                  : const Icon(
                                      Icons.favorite_border_outlined,
                                      color: Color.fromARGB(225, 0, 0, 0),
                                      size: 32,
                                    );
                            },
                            onTap: (isLiked) async {
                              if (FavoritesDB.isfavorite(
                                  widget.songlist[currentIndex])) {
                                FavoritesDB.removefromfav(
                                    widget.songlist[currentIndex].id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(20))),
                                        duration: Duration(milliseconds: 250),
                                        backgroundColor:
                                            Color.fromARGB(255, 99, 7, 0),
                                        content: Text(
                                          'Removed from Favorites',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  179, 255, 255, 255),
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700),
                                        )));
                              } else {
                                FavoritesDB.addtofav(
                                    widget.songlist[currentIndex]);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(20))),
                                        duration: Duration(milliseconds: 250),
                                        backgroundColor:
                                            Color.fromARGB(255, 131, 131, 131),
                                        content: Text(
                                          'Added to Favorites',
                                          style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 86, 0, 0),
                                              fontSize: 19,
                                              fontWeight: FontWeight.w700),
                                        )));
                              }
                              FavoritesDB.favorites.notifyListeners();
                              Variableclass.instance.isclickedd
                                  .notifyListeners();
                              return !isLiked;
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              const SizedBox(
                height: 16,
              ),
              StreamBuilder<DurationState>(
                stream: _durationStateStream,
                builder: (context, snapshot) {
                  final durationState = snapshot.data;
                  final progress = durationState?.position ?? Duration.zero;
                  final total = durationState?.total ?? Duration.zero;
                  return ProgressBar(
                    barHeight: 10,
                    thumbColor: Colors.black,
                    baseBarColor: const Color.fromARGB(255, 103, 103, 103),
                    barCapShape: BarCapShape.round,
                    progressBarColor: const Color.fromARGB(255, 0, 0, 0),
                    timeLabelTextStyle: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                    progress: progress,
                    total: total,
                    onSeek: (duration) {
                      Variableclass.audioPlayer.seek(duration);
                    },
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.repeat_on_rounded),
                    iconSize: 30,
                  ),
                  ShuffleButton(),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () async {
                        if (Variableclass.audioPlayer.hasPrevious) {
                          await Variableclass.audioPlayer.seekToPrevious();
                          await Variableclass.audioPlayer.play();
                          Variableclass.passedindexx = currentIndex;

                          Variableclass.instance.isclickedd.notifyListeners();
                        } else {
                          await Variableclass.audioPlayer.play();
                        }
                      },
                      child: const NeumorphicWidget(
                        child: Icon(
                          Icons.skip_previous_rounded,
                          size: 55,
                        ),
                      ),
                    ),
                    const AnimatedNeumorphism(),
                    GestureDetector(
                      onTap: () async {
                        if (Variableclass.audioPlayer.hasNext) {
                          await Variableclass.audioPlayer.seekToNext();
                          await Variableclass.audioPlayer.play();
                          Variableclass.passedindexx = currentIndex;

                          Variableclass.instance.isclickedd.notifyListeners();
                        } else {
                          await Variableclass.audioPlayer.play();
                        }
                      },
                      child: const NeumorphicWidget(
                        child: Icon(
                          Icons.skip_next_rounded,
                          size: 55,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void changetoseconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    Variableclass.audioPlayer.seek(duration);
  }

  Stream<DurationState> get _durationStateStream =>
      Rx.combineLatest2<Duration, Duration?, DurationState>(
          Variableclass.audioPlayer.positionStream,
          Variableclass.audioPlayer.durationStream,
          (position, duration) => DurationState(
              position: position, total: duration ?? Duration.zero));
}

class DurationState {
  DurationState({this.position = Duration.zero, this.total = Duration.zero});
  Duration position, total;
}
