import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project1_ui1/dbmodel/foldermodel.dart';

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
}
