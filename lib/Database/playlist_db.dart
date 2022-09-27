// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project1_ui1/Database/favoritesdb.dart';
import 'package:project1_ui1/dbmodel/foldermodel.dart';
import 'package:project1_ui1/pages/splash_screen.dart';

const playlistdbname = 'PlaylistDB';

class PlaylistDB {
  PlaylistDB.privateconstructor();

  static final PlaylistDB _instance = PlaylistDB.privateconstructor();
  static PlaylistDB get instance => _instance;
  ValueNotifier<List<FolderModel>> playlistnotifier = ValueNotifier([]);

  Future<void> addfolder(FolderModel model) async {
    final pdb = Hive.box<FolderModel>(playlistdbname);

    await pdb.add(model);
    playlistnotifier.value.add(model);
  }

  Future<void> getallfolder() async {
    final pdb = Hive.box<FolderModel>(playlistdbname);
    playlistnotifier.value.clear();
    playlistnotifier.value.addAll(pdb.values);
    playlistnotifier.notifyListeners();
  }

  Future<void> deletefolder(int index) async {
    final pdb = Hive.box<FolderModel>(playlistdbname);
    await pdb.deleteAt(index);
    getallfolder();
  }

  Future<void> reset(context) async {
    final pdb = Hive.box<FolderModel>(playlistdbname);
    final favdb = Hive.box<int>('favoritedb');
    await pdb.clear();
    await favdb.clear();
    FavoritesDB.favorites.value.clear();
    Navigator.of(context).pushAndRemoveUntil(
        PageTransition(
            child: const SplashScreen(), type: PageTransitionType.bottomToTop),
        (route) => false);
  }
}
