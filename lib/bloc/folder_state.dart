part of 'folder_bloc.dart';

abstract class FolderState extends Equatable {
  const FolderState();
}

class FolderInitial extends FolderState {
  @override
  List<Object> get props => [];
}

class DisplayFolder extends FolderState {
  final List<FolderModel> folders;

  const DisplayFolder({required this.folders});
  @override
  List<Object> get props => [folders];
}
