part of 'note_bloc.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NoteInitialized extends NoteState {
  final List<Note> noteList;
  const NoteInitialized({@required this.noteList});
  @override
  List<Object> get props => [noteList];
}

class NoteNavigated extends NoteState {
  final String appBarTitle;
  final Note note;

  const NoteNavigated({@required this.appBarTitle, @required this.note});

  @override
  List<Object> get props => [appBarTitle, note];
}

class NoteResponse extends NoteState {
  final String message;

  const NoteResponse({@required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'Response {message: $message}';
}
