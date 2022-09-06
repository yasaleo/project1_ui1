import 'package:flutter/foundation.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Variableclass {

  Variableclass.privateconstructor();
  static final Variableclass _instance = Variableclass.privateconstructor();
  static Variableclass get instance => _instance;


  ValueNotifier< bool> isclickedd = ValueNotifier(false);
  static List<SongModel> songlist = [];
  

}