import 'package:hive_flutter/hive_flutter.dart';

part 'foldermodel.g.dart';

@HiveType(typeId: 1)
class FolderModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  List<int> songids;
  @HiveField(2)
  String image;

  FolderModel({
    required this.image,
    required this.name,
    required this.songids,
  });

  add(int id) async {
    songids.add(id);
    save();
  }

  deletedata(int id) {
    songids.remove(id);
    save();

  }

  bool isValuein(int id) {
    return songids.contains(id);
  }
}
