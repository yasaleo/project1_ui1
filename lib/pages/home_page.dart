import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

import 'package:like_button/like_button.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:project1_ui1/animated_neu.dart';
import 'package:project1_ui1/dbmodel/foldermodel.dart';
import 'package:project1_ui1/neumorphism.dart';
import 'package:project1_ui1/pages/custom_animated.dart';

import '../Database/favoritesdb.dart';
import '../Database/playlist_db.dart';
import '../commonvariables.dart';
import 'package:rxdart/rxdart.dart';

class HomeScreen extends StatefulWidget {
  final List<SongModel> songlist;

  const HomeScreen({
    Key? key,
    required this.songlist,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
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
          child: SingleChildScrollView(
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
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Container(
                                color: const Color.fromRGBO(0, 0, 0, 0.001),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: DraggableScrollableSheet(
                                    initialChildSize: 0.4,
                                    minChildSize: 0.2,
                                    maxChildSize: 0.75,
                                    builder: (_, controller) {
                                      return Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.0),
                                            topRight: Radius.circular(25.0),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.remove,
                                              color: Colors.grey[600],
                                            ),
                                            Expanded(
                                              child: ValueListenableBuilder(
                                                  valueListenable: PlaylistDB
                                                      .instance
                                                      .playlistnotifier,
                                                  builder: (context,
                                                      List<FolderModel> value,
                                                      Widget? _) {
                                                    return value.isEmpty
                                                        ? Center(
                                                            child: Column(
                                                              children: [
                                                                LottieBuilder
                                                                    .asset(
                                                                  'assets/WaYDLCo9Ux.json',
                                                                  width: 170,
                                                                  height: 170,
                                                                ),
                                                                const Text(
                                                                  'No Playlist found !',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          40,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        : ListView.builder(
                                                            controller:
                                                                controller,
                                                            itemCount:
                                                                value.length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left: 8,
                                                                        right:
                                                                            8,
                                                                        bottom:
                                                                            8),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  child:
                                                                      BackdropFilter(
                                                                    filter: ImageFilter.blur(
                                                                        sigmaX:
                                                                            4,
                                                                        sigmaY:
                                                                            4),
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        boxShadow: const [
                                                                          BoxShadow(
                                                                            color: Color.fromARGB(
                                                                                26,
                                                                                0,
                                                                                0,
                                                                                0),
                                                                            blurRadius:
                                                                                8,
                                                                            spreadRadius:
                                                                                1,
                                                                            offset:
                                                                                Offset(0, 0),
                                                                          ),
                                                                        ],
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      child:
                                                                          ListTile(
                                                                        horizontalTitleGap:
                                                                            8,
                                                                        onTap:
                                                                            () {
                                                                          if (value[index].isValuein(widget
                                                                              .songlist[currentIndex]
                                                                              .id)) {
                                                                            value[index].deletedata(widget.songlist[currentIndex].id);
                                                                            PlaylistDB.instance.playlistnotifier.notifyListeners();
                                                                          } else {
                                                                            value[index].add(widget.songlist[currentIndex].id);
                                                                            PlaylistDB.instance.playlistnotifier.notifyListeners();
                                                                          }
                                                                        },
                                                                        leading:
                                                                            CircleAvatar(
                                                                          radius:
                                                                              25,
                                                                          backgroundColor: const Color.fromARGB(
                                                                              13,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          foregroundColor:
                                                                              Colors.black54,
                                                                          child:
                                                                              Text("$index"),
                                                                        ),
                                                                        title:
                                                                            Text(
                                                                          value[index]
                                                                              .name,
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: const TextStyle(
                                                                              fontSize: 19,
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                        trailing: SizedBox(
                                                                            height:
                                                                                55,
                                                                            width:
                                                                                35,
                                                                            child:
                                                                                AddRemoveButton(isclickedd: value[index].isValuein(widget.songlist[currentIndex].id))),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                  }),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        );
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
                                  child: AnimatedSwitcher(
                                    switchInCurve: Curves.easeOutQuad,
                                    duration: const Duration(milliseconds: 600),
                                    transitionBuilder:
                                        (child, Animation<double> animation) {
                                      return SlideTransition(
                                        position: Tween<Offset>(
                                                begin: const Offset(-09.0, 0),
                                                end: const Offset(0.0, 0.0))
                                            .animate(animation),
                                        child: child,
                                      );
                                    },
                                    child: Marquee(
                                      key: UniqueKey(),
                                      showFadingOnlyWhenScrolling: false,
                                      fadingEdgeStartFraction: .2,
                                      fadingEdgeEndFraction: .17,
                                      text: widget.songlist[currentIndex]
                                          .displayNameWOExt,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                      blankSpace: 90,
                                      velocity: 35,
                                      pauseAfterRound:
                                          const Duration(milliseconds: 900),
                                    ),
                                  ),
                                ),
                                const Divider(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 30,
                                  width: 190,
                                  child: AnimatedSwitcher(
                                    switchInCurve: Curves.easeOutQuad,
                                    duration: const Duration(milliseconds: 800),
                                    transitionBuilder:
                                        (child, Animation<double> animation) {
                                      return SlideTransition(
                                        position: Tween<Offset>(
                                                begin: const Offset(-04.0, 0),
                                                end: const Offset(0.0, 0.0))
                                            .animate(animation),
                                        child: child,
                                      );
                                    },
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
                                      key: UniqueKey(),
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
                                dotPrimaryColor:
                                    Color.fromARGB(255, 255, 22, 1),
                                dotSecondaryColor:
                                    Color.fromARGB(255, 125, 0, 0),
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
                                                  topRight:
                                                      Radius.circular(20))),
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
                                                  topRight:
                                                      Radius.circular(20))),
                                          duration: Duration(milliseconds: 250),
                                          backgroundColor: Color.fromARGB(
                                              255, 131, 131, 131),
                                          content: Text(
                                            'Added to Favorites',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 86, 0, 0),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const <Widget>[
                      LoopButton(),
                      ShuffleButton(),
                    ],
                  ),
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
                ),
              ],
            ),
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
