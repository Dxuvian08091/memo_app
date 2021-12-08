import 'package:flutter/material.dart';
import 'package:flutter_app/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_app/logic/bloc/note_bloc/note_bloc.dart';
import 'package:flutter_app/presentation/screens/note_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/data/models/note.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {
  _onNoteListChanged() {
    BlocProvider.of<NoteBloc>(context).add(UpdateNoteList());
  }

  _navigateToDetail(Note note, String appBarTitle) =>
      BlocProvider.of<NoteBloc>(context)
          .add(NavigateToNote(appBarTitle: appBarTitle, note: note));
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteBloc, NoteState>(
      listener: (context, state) {
        if (state is NoteResponse) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${state.message}'),
            backgroundColor: Colors.red,
          ));
        }
      },
      builder: (context, state) {
        if (state is NoteNavigated) {
          return NoteDetail(state.note, state.appBarTitle);
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('Notes'),
              actions: [
                IconButton(
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(LoggedOut());
                    },
                    icon: Icon(Icons.logout))
              ],
            ),
            body: getNoteListView(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _navigateToDetail(Note('', '', 2), 'Add Note');
              },
              tooltip: 'Add Note',
              child: Icon(Icons.add),
            ),
          );
        }
      },
    );
  }

  //provides a list view of objects in the noteList
  ListView getNoteListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subtitle1;
    List<Note> noteList = BlocProvider.of<NoteBloc>(context).noteList;
    return ListView.builder(
      itemCount: noteList.length,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getPriorityColor(noteList[position].priority),
              child: getPriorityIcon(noteList[position].priority),
            ),
            title: Text(
              noteList[position].title,
              style: titleStyle,
            ),
            subtitle: Text(noteList[position].date),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                BlocProvider.of<NoteBloc>(context)
                    .add(DeleteNote(note: noteList[position]));
                _onNoteListChanged();
              },
            ),
            onTap: () {
              debugPrint("ListTile Tapped");
              _navigateToDetail(noteList[position], 'Edit Note');
            },
          ),
        );
      },
    );
  }

  // Returns the priority color
  Color getPriorityColor(int priority) {
    return priority == 1 ? Colors.red : Colors.yellow;
  }

  // Returns the priority icon
  Icon getPriorityIcon(int priority) {
    return priority == 1
        ? Icon(Icons.play_arrow)
        : Icon(Icons.keyboard_arrow_right);
  }
}
