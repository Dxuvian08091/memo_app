import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/models/note.dart';
import 'package:flutter_app/presentation/screens/note_list.dart';
import 'package:flutter_app/utils/database_helper.dart';

class NoteListScreen extends StatelessWidget {
  final DatabaseHelper databaseHelper;
  final List<Note> noteList;
  NoteListScreen(
      {Key key, @required this.databaseHelper, @required this.noteList})
      : assert(databaseHelper != null),
        assert(noteList != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return NoteList();
  }
}
