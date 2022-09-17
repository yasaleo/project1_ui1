import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Variableclass {
  Variableclass.privateconstructor();
  static final Variableclass _instance = Variableclass.privateconstructor();
  static Variableclass get instance => _instance;
  static late AnimationController _controller;

  static late final SongModel songModel;
  static late final AudioPlayer audioPlayer;
  static late final List<SongModel> allsonglist;

  static List<SongModel> songscopy = [];

  static late final int passedindexx;

  ValueNotifier<bool> isvisible = ValueNotifier(false);

  ValueNotifier<bool> isclickedd = ValueNotifier(false);
  static List<SongModel> songlist = [];
}
