import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 1)
class FavoritesModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final int songids;

  FavoritesModel({
    required this.songids,
    required this.id,
  });

}
