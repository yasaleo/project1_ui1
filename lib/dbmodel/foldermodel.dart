import 'package:hive_flutter/hive_flutter.dart';
part 'foldermodel.g.dart';

@HiveType(typeId: 1)
class FolderModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  List<int> songids;

  FolderModel({
    required this.name,
    required this.songids,
  });

  add(int id) async {
    songids.add(id);
  }

  deletedata(int id) {
    songids.remove(id);
  }

  bool isValuein(int id) {
    return songids.contains(id);
  }
}
