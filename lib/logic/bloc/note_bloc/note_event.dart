part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class SaveNote extends NoteEvent {
  final Note note;

  const SaveNote({@required this.note});

  @override
  List<Object> get props => [note];
}

class DeleteNote extends NoteEvent {
  final Note note;

  const DeleteNote({@required this.note});

  @override
  List<Object> get props => [note];
}

class UpdateNoteList extends NoteEvent {}

class NavigateToNote extends NoteEvent {
  final String appBarTitle;
  final Note note;

  const NavigateToNote({@required this.appBarTitle, @required this.note});

  @override
  List<Object> get props => [appBarTitle, note];
}
