import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/data/models/note.dart';
import 'package:flutter_app/utils/database_helper.dart';
import 'package:intl/intl.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final DatabaseHelper databaseHelper;
  List<Note> noteList;
  NoteBloc({@required this.databaseHelper, @required this.noteList})
      : assert(databaseHelper != null),
        assert(noteList != null),
        super(NoteInitial()) {
    on<SaveNote>((event, emit) async {
      emit(NoteLoading());
      event.note.date = DateFormat.yMMMd().format(DateTime.now());
      int result;
      if (event.note.id != null) {
        result = await databaseHelper.updateNote(event.note);
      } else {
        result = await databaseHelper.insertNote(event.note);
      }

      if (result != 0) {
        emit(NoteResponse(message: 'Note Saved Successfully'));
      } else {
        emit(NoteResponse(message: 'Problem Saving Note'));
      }
      emit(NoteInitialized(noteList: noteList));
    });
    on<DeleteNote>((event, emit) async {
      emit(NoteLoading());
      if (event.note.id == null) {
        emit(NoteResponse(message: 'No Note was deleted'));
      } else {
        int result = await databaseHelper.deleteNote(event.note.id);
        if (result != 0) {
          emit(NoteResponse(message: "Note Deleted Successfully"));
        } else {
          emit(NoteResponse(message: "Error Occured while Deleting Note"));
        }
      }
      emit(NoteInitialized(noteList: noteList));
    });
    on<UpdateNoteList>((event, emit) async {
      await databaseHelper.initializeDatabase();
      List<Note> noteListFuture = await databaseHelper.getNoteList();
      emit(NoteInitialized(noteList: noteListFuture));
      noteList = noteListFuture;
    });
    on<NavigateToNote>((event, emit) =>
        emit(NoteNavigated(appBarTitle: event.appBarTitle, note: event.note)));
  }
}
