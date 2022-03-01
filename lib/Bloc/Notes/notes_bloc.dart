import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:keep_notes/Models/NoteModels.dart';
import 'package:flutter/material.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  
  NotesBloc() : super(NotesState()) {

    on<AddNoteFrave>(_addNewNote);
    on<SelectedColorEvent>(_selectedColor);
    on<SelectedCategoryEvent>(_selectedCategory);
    on<ChangedListToGrid>(_changedListToGrid);
    on<UpdateNoteEvent>(_updateNote);
    on<DeleteNoteEvent>(_deleteNote);
    on<LengthAllNotesEvent>(_lengthAllNotes);

  }

  Future<void> _addNewNote(AddNoteFrave event, Emitter<NotesState> emit) async {

    var box = Hive.box<NoteModels>('keepNote');

    var noteModel = NoteModels(
      title : event.title,
      body : event.body,
      color: state.color,
      isComplete: event.isComplete,
      category: event.category,
      created : DateTime.now()
    );

    box.add(noteModel); 

  }


  Future<void> _selectedColor(SelectedColorEvent event, Emitter<NotesState> emit) async {

    emit(state.copyWith(color: event.color));

  }


  Future<void> _selectedCategory(SelectedCategoryEvent event, Emitter<NotesState> emit) async {

    emit(state.copyWith(category: event.category, colorCategory: event.colorCategory));

  }


  Future<void> _changedListToGrid(ChangedListToGrid event, Emitter<NotesState> emit) async {

    emit(state.copyWith(isList: event.isList));

  }


  Future<void> _updateNote(UpdateNoteEvent event, Emitter<NotesState> emit) async {

    var box = Hive.box<NoteModels>('keepNote');

    var noteModel = NoteModels(
      title : event.title,
      body : event.body,
      color: state.color,
      isComplete: event.isComplete,
      category: event.category,
      created : DateTime.now()
    );

    box.putAt(event.index, noteModel);

  }


  Future<void> _deleteNote(DeleteNoteEvent event, Emitter<NotesState> emit) async {

    var box = Hive.box<NoteModels>('keepNote');

    box.deleteAt(event.index);

  }


  Future<void> _lengthAllNotes(LengthAllNotesEvent event, Emitter<NotesState> emit) async {

    emit(state.copyWith(noteLength: event.length));

  }

  

}
