import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

import 'package:on_audio_query/on_audio_query.dart';

class Variableclass {
  Variableclass.privateconstructor();
  static final Variableclass _instance = Variableclass.privateconstructor();
  static Variableclass get instance => _instance;

  static AudioPlayer audioPlayer = AudioPlayer();

  static List<SongModel> songscopy = [];

  // for full song lists-------------------------------------------------------------------------
  static List<SongModel> fullsongmodellist = [];

//for miniplayer----------------------------------------------------------------------------------
  static List<SongModel> miniplsonglist = [];
  ValueNotifier<int> miniindex = ValueNotifier(0);
  static bool minivisible = false;

  static late final int passedindexx;

  ValueNotifier<bool> isvisible = ValueNotifier(false);

  ValueNotifier<bool> isclickedd = ValueNotifier(false);
  static List<SongModel> songlist = [];

  static List<SongModel> allsonglist = [];
  static ConcatenatingAudioSource playsongs(List<SongModel> songs) {
    List<AudioSource> sources = [];
    allsonglist = songs;
    for (var song in songs) {
      sources.add(AudioSource.uri(
        Uri.parse(song.uri!),
      ));
    }
    return ConcatenatingAudioSource(children: sources);
  }
}
