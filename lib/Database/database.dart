import 'package:hive_flutter/hive_flutter.dart';
import 'package:project1_ui1/Database/model.dart';

const dbname = 'music-database';

class MusicDatabase {
  Future<void> addfavorites(FavoritesModel value) async {
    final mdb = await Hive.openBox<FavoritesModel>(dbname);
    await  mdb.add(value);
  }

  // Future<List<FavoritesModel>>getfavorites() async{
 
  // }
}
