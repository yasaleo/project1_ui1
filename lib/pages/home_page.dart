import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:like_button/like_button.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:project1_ui1/animated_neu.dart';
import 'package:project1_ui1/neumorphism.dart';

class HomeScreen extends StatefulWidget {
  final SongModel songModel;
  final AudioPlayer audioPlayer;
  final List<SongModel> songlist;
  final bool isclicked;

  int passedindex;

  HomeScreen(
      {Key? key,
      required this.songModel,
      required this.audioPlayer,
      required this.songlist,
      required this.isclicked,
      required this.passedindex})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<Duration> _duration = ValueNotifier(const Duration());
  final ValueNotifier<Duration> _position = ValueNotifier(const Duration());

  playsong(String? uri) {
    try {
      widget.audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      widget.audioPlayer.play();
    } on Exception {
      log('Error parsing song');
    }
  }

  songduration() {
    widget.audioPlayer.durationStream.listen((event) {
      _duration.value = event!;
    });

    widget.audioPlayer.positionStream.listen((e) {
      _position.value = e;
    });
  }

  void seektoduration(int seconds) {
    Duration duration = Duration(seconds: seconds);
    widget.audioPlayer.seek(duration);
  }

  @override
  void initState() {
    songduration();
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
                        child: Icon(size: 38, Icons.arrow_back_ios_new),
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
                  const NeumorphicWidget(
                    child: Icon(
                      Icons.menu,
                      size: 38,
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
                        child: QueryArtworkWidget(
                          artworkFit: BoxFit.fill,
                          artworkBorder: BorderRadius.circular(10),
                          id: widget.songlist[widget.passedindex].id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: const Icon(
                            Icons.music_note_outlined,
                            size: 50,
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
                                  text: widget.songlist[widget.passedindex]
                                      .displayNameWOExt,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600
                                  ),
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
                                child:

                                Text(
                                  widget.songlist[widget.passedindex].artist
                                              .toString() ==
                                          "<unknown>"
                                      ? 'Unknown Artist'
                                      : widget
                                          .songlist[widget.passedindex].artist
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
                              return Icon(
                                Icons.favorite,
                                color: isLiked
                                    ? const Color.fromARGB(255, 129, 9, 0)
                                    : Colors.black,
                                size: 33,
                              );
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 46,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ValueListenableBuilder(
                      valueListenable: _position,
                      builder: (BuildContext context, Duration newduration,
                          Widget? _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              newduration.toString().split(".")[0],
                              style: const TextStyle(fontSize: 17),
                            ),
                            Text(
                              _duration.value.toString().split(".")[0],
                              style: const TextStyle(fontSize: 17),
                            )
                          ],
                        );
                      })),
              const SizedBox(
                height: 16,
              ),
              ValueListenableBuilder(
                  valueListenable: _position,
                  builder: (BuildContext context, Duration newd, Widget? _) {
                    return Slider(
                      activeColor: Colors.black,
                      inactiveColor: const Color.fromARGB(242, 92, 92, 92),
                      min: const Duration(microseconds: 0).inSeconds.toDouble(),
                      max: _duration.value.inSeconds.toDouble(),
                      value: _position.value.inSeconds.toDouble(),
                      onChanged: (value) {
                        seektoduration(value.toInt());
                        value = value;
                      },
                    );
                  }),
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (widget.passedindex < 0) {
                            widget.passedindex = 0;
                            playsong(widget.songlist[widget.passedindex].uri);
                          } else {
                            widget.passedindex--;
                            playsong(widget.songlist[widget.passedindex].uri);
                          }
                        });
                      },
                      child: const NeumorphicWidget(
                        child: Icon(
                          Icons.skip_previous_rounded,
                          size: 55,
                        ),
                      ),
                    ),
                    AnimatedNeumorphism(
                      audioPlayer: widget.audioPlayer,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (widget.passedindex > widget.songlist.length) {
                            widget.passedindex = widget.songlist.length;
                            playsong(widget.songlist[widget.passedindex].uri);
                          } else {
                            widget.passedindex++;
                            playsong(widget.songlist[widget.passedindex].uri);
                          }
                        });
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
}
