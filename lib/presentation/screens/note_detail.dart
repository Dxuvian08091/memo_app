import 'package:flutter/material.dart';
import 'package:flutter_app/data/models/note.dart';
import 'package:flutter_app/logic/bloc/note_bloc/note_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'note_list.dart';

class NoteDetail extends StatefulWidget {
  final String appBarTitle;
  final Note note;

  NoteDetail(this.note, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return NoteDetailState(this.note, this.appBarTitle);
  }
}

class NoteDetailState extends State<NoteDetail> {
  static var _priorities = ['High', 'Low'];

  String appBarTitle;
  Note note;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  NoteDetailState(this.note, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    _onSaveButtonPressed(Note note) =>
        BlocProvider.of<NoteBloc>(context).add(SaveNote(note: note));
    _onDeleteButtonPressed(Note note) =>
        BlocProvider.of<NoteBloc>(context).add(DeleteNote(note: note));
    _onNoteListChanged() {
      BlocProvider.of<NoteBloc>(context).add(UpdateNoteList());
    }

    TextStyle textStyle = Theme.of(context).textTheme.headline6;

    titleController.text = note.title;
    descriptionController.text = note.description;

    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        if (state is NoteInitialized) {
          return NoteList();
        } else {
          return WillPopScope(
              onWillPop: () {
                // Write some code to control things, when user press Back navigation button in device navigationBar
                _onNoteListChanged();
                return null;
              },
              child: Scaffold(
                appBar: AppBar(
                  title: Text(appBarTitle),
                  leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        debugPrint('back_arrow was pressed');
                        // Write some code to control things, when user press back button in AppBar
                        _onNoteListChanged();
                      }),
                ),
                body: Padding(
                  padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                  child: ListView(
                    children: <Widget>[
                      // First element
                      ListTile(
                        title: DropdownButton(
                            items: _priorities.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                            style: textStyle,
                            value: getPriorityAsString(note.priority),
                            onChanged: (valueSelectedByUser) {
                              setState(() {
                                debugPrint(
                                    'User selected $valueSelectedByUser');
                                updatePriorityAsInt(valueSelectedByUser);
                              });
                            }),
                      ),

                      // Second Element
                      Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: TextField(
                          controller: titleController,
                          style: textStyle,
                          onChanged: (value) {
                            debugPrint('Something changed in Title Text Field');
                            updateTitle();
                          },
                          decoration: InputDecoration(
                            labelText: 'Title',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),

                      // Third Element
                      Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: TextField(
                          controller: descriptionController,
                          style: textStyle,
                          onChanged: (value) {
                            debugPrint(
                                'Something changed in Description Text Field');
                            updateDescription();
                          },
                          decoration: InputDecoration(
                            labelText: 'Description',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),

                      // Fourth Element
                      Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<
                                            Color>(
                                        Theme.of(context).primaryColorDark)),
                                child: Text(
                                  'Save',
                                  textScaleFactor: 1.5,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorLight,
                                  ),
                                ),
                                onPressed: () {
                                  _onSaveButtonPressed(note);
                                  _onNoteListChanged();
                                },
                              ),
                            ),
                            Container(
                              width: 5.0,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<
                                            Color>(
                                        Theme.of(context).primaryColorDark)),
                                child: Text(
                                  'Delete',
                                  textScaleFactor: 1.5,
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorLight),
                                ),
                                onPressed: () {
                                  _onDeleteButtonPressed(note);
                                  _onNoteListChanged();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        }
      },
    );
  }

  // Convert the String priority in the form of integer before saving it to Database
  void updatePriorityAsInt(String value) {
    note.priority = value == 'High' ? 1 : 2;
  }

  // Convert int priority to String priority and display it to user in DropDown
  String getPriorityAsString(int value) {
    return value == 1 ? _priorities[0] : _priorities[1];
  }

  // Update the title of Note object
  void updateTitle() {
    note.title = titleController.text;
  }

  // Update the description of Note object
  void updateDescription() {
    note.description = descriptionController.text;
  }
}
