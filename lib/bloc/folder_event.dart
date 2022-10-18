part of 'folder_bloc.dart';

abstract class FolderEvent extends Equatable {
  const FolderEvent();
}

class AddFolder extends FolderEvent {
  final String name;
  final List<int> songids;
  final String image;

  const AddFolder({
    required this.name,
    required this.songids,
    required this.image,
  });

  @override
  List<Object?> get props => [
        name,
        songids,
        songids,
      ];
}

class UpdateFolder extends FolderEvent {
  final FolderModel folderModel;

  const UpdateFolder({required this.folderModel});

  @override
  List<Object?> get props => [];
}

class FetchFolders extends FolderEvent {
  const FetchFolders();
  @override
  List<Object?> get props => [];
}

class DeleteFolders extends FolderEvent {
  final int index;

 const DeleteFolders({required this.index});

 @override
  List<Object?> get props  => [];
}


