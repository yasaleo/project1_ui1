import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';

class Variableclass {

  Variableclass.privateconstructor();
  static final Variableclass _instance = Variableclass.privateconstructor();
  static Variableclass get instance => _instance;


  ValueNotifier< bool> isclickedd = ValueNotifier(false);
   

}