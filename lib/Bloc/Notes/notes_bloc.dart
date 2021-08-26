import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:keep_notes/Models/NoteModels.dart';
import 'package:flutter/material.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  
  NotesBloc() : super(NotesState());

  @override
  Stream<NotesState> mapEventToState( NotesEvent event ) async* {

    if ( event is AddNoteFrave ){

        var box = await Hive.openBox<NoteModels>('keepNote');

        var noteModel = NoteModels(
          title : event.title,
          body : event.body,
          color: state.color,
          isComplete: event.isComplete,
          category: event.category,
          created : DateTime.now()
        );

        box.add(noteModel); 


    } else if ( event is SelectedColorEvent ){

      yield state.copyWith(
        color: event.color
      );


    } else if ( event is SelectedCategoryEvent ){

      yield state.copyWith(
        category: event.category,
        colorCategory: event.colorCategory
      );


    } else if ( event is ChangedListToGrid ){

      yield state.copyWith(
        isList: event.isList
      );


    } else if ( event is UpdateNoteEvent ){

       var box = await Hive.openBox<NoteModels>('keepNote');

       var noteModel = NoteModels(
          title : event.title,
          body : event.body,
          color: state.color,
          isComplete: event.isComplete,
          category: event.category,
          created : DateTime.now()
        );

        box.putAt(event.index, noteModel);
    
    
    } else if ( event is DeleteNoteEvent ){

      var box = await Hive.openBox<NoteModels>('keepNote');

      box.deleteAt(event.index);

    }
  }
}
