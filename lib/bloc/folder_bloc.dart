import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project1_ui1/Database/playlist_db.dart';
import 'package:project1_ui1/dbmodel/foldermodel.dart';

part 'folder_event.dart';
part 'folder_state.dart';

class FolderBloc extends Bloc<FolderEvent, FolderState> {
  FolderBloc() : super(FolderInitial()) {
    List<FolderModel> folders;

    on<AddFolder>(
      (event, emit) async {
        await PlaylistDB.instance.addfolder(
          FolderModel(
            image: event.image,
            name: event.name,
            songids: event.songids,
          ),
        );
      },
    );

    on<UpdateFolder>(
      (event, emit) async {
        event.folderModel;
      },
    );

    on<FetchFolders>(
      (event, emit) async {
        folders = await PlaylistDB.instance.getallfolder();
        emit(DisplayFolder(folders: folders));
      },
    );

    on<DeleteFolders>(
      (event, emit) async {
        await PlaylistDB.instance.deletefolder(event.index);
        add(const FetchFolders());
      },
    );
  }
}
