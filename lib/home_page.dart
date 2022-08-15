import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:like_button/like_button.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:project1_ui1/animated_neu.dart';
import 'package:project1_ui1/neumorphism.dart';

class HomeScreen extends StatefulWidget {
  final SongModel songModel;
  final AudioPlayer audioPlayer;
  List<SongModel> songlist;
  bool isclicked;

  int passedindex;

  HomeScreen(
      {Key? key,
      required this.songModel,
      required this.audioPlayer,
      required this.songlist,
      required this.isclicked,
      required this.passedindex})
      : super(key: key);
  ValueNotifier<List<SongModel>> songnotifier = ValueNotifier([]);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  playsong(String? uri) {
    try {
      widget.audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(uri!)
        )

      );
      widget.audioPlayer.play();
    } on Exception {
      log('Error parsing song');
    }
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
                    child: const NeumorphicWidget(
                      child: Icon(
                        Icons.arrow_downward,
                        size: 38,
                      ),
                    ),
                  ),
                  const Text(
                    'Music',
                    style: TextStyle(
                        fontSize: 30,
                        letterSpacing: 10,
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
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: AspectRatio(
                        aspectRatio: 1.5 / 1,
                        child: Image.asset(
                            'assets/keagan-henman-6etHcucBiRg-unsplash.jpg'),
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
                                width: 270,
                                child: Text(
                                  widget.songlist[widget.passedindex].displayNameWOExt,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              const Divider(
                                height: 10,
                              ),
                              SizedBox(
                                width: 230,
                                child: Text(
                                 widget.songlist[widget.passedindex].artist.toString() ==
                                          "<unknown>"
                                      ? 'Unknown Artist'
                                      : widget.songlist[widget.passedindex].artist.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 23,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      '0.0',
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      '4.48',
                      style: TextStyle(fontSize: 17),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              LinearPercentIndicator(
                backgroundColor: const Color.fromARGB(255, 194, 194, 194),
                lineHeight: 10,
                percent: 0.8,
                progressColor: Colors.black,
                barRadius: const Radius.circular(8),
              ),
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (widget.passedindex<0) {
                          widget.passedindex=0;
                        playsong(widget.songlist[widget.passedindex].uri);

                        } else{
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
                      isclickedd: widget.isclicked,

                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (widget.passedindex>widget.songlist.length) {
                          widget.passedindex=widget.songlist.length;
                        playsong(widget.songlist[widget.passedindex].uri);

                        } else{
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
