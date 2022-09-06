import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavoritesDB {
  static final favordb = Hive.box<int>('favoritedb');
  static bool isintialised = false;
  static ValueNotifier<List<SongModel>> favorites = ValueNotifier([]);

  static intialise(List<SongModel> songs) {
    for (SongModel song in songs) {
      if (isfavorite(song)) {
        favorites.value.add(song);
      }
    }
    isintialised = true;
  }

  static bool isfavorite(SongModel song) {
    if (favordb.values.contains(song.id)) {
      return true;
    }
    return false;
  }

  static addtofav(SongModel songg) async {
    favordb.add(songg.id);
    favorites.value.add(songg);
    FavoritesDB.favorites.notifyListeners();
    allfavsongs(songg);
  }

  static allfavsongs(songg) async {
    favorites.value.addAll(songg);
  }

  static removefromfav(int id) async {
    int deltekey = 0;
    if (!favordb.values.contains(id)) {
      return;
    }
    final Map<dynamic, int> favormap = favordb.toMap();
    favormap.forEach((key, value) {
      if (value == id) {
        deltekey = key;
      }
    });
    favordb.delete(deltekey);
    favorites.value.removeWhere((element) => element.id == id);
  }
}
