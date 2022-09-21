
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

import 'package:on_audio_query/on_audio_query.dart';

class Variableclass {
  Variableclass.privateconstructor();
  static final Variableclass _instance = Variableclass.privateconstructor();
  static Variableclass get instance => _instance;

  static  AudioPlayer audioPlayer = AudioPlayer();
  static  List<SongModel> allsonglist= [];

  static List<SongModel> songscopy = [];

  static late final int passedindexx;

  ValueNotifier<bool> isvisible = ValueNotifier(false);

  ValueNotifier<bool> isclickedd = ValueNotifier(false);
  static List<SongModel> songlist = [];

  static ConcatenatingAudioSource playsongs(List<SongModel> songs) {
    List<AudioSource> sources = [];
    allsonglist = songs;
    for (var song in songs) {
      sources.add(AudioSource.uri(Uri.parse(song.uri!),
          ));
    }
    return ConcatenatingAudioSource(children: sources);
  }
}
