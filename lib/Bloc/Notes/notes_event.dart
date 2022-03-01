part of 'notes_bloc.dart';

@immutable
abstract class NotesEvent {}

class AddNoteFrave extends NotesEvent {
  final String title;
  final String body;
  final DateTime created;
  final int color;
  final String category;
  final bool isComplete;

  AddNoteFrave({
    required this.title, 
    required this.body, 
    required this.created, 
    required this.color,
    required this.category, 
    required this.isComplete
  });
}


class SelectedColorEvent extends NotesEvent {
  final int color;

  SelectedColorEvent(this.color);
}


class SelectedCategoryEvent extends NotesEvent {
  final String category;
  final Color colorCategory;

  SelectedCategoryEvent(this.category, this.colorCategory);
}


class ChangedListToGrid extends NotesEvent {
  final bool isList;

  ChangedListToGrid(this.isList);
}


class UpdateNoteEvent extends NotesEvent {
  final String title;
  final String body;
  final DateTime created;
  final int color;
  final String category;
  final bool isComplete;
  final int index;

  UpdateNoteEvent({
    required this.title, 
    required this.body, 
    required this.created, 
    required this.color,
    required this.category, 
    required this.isComplete,
    required this.index
  });
}

class DeleteNoteEvent extends NotesEvent {
  final int index;

  DeleteNoteEvent(this.index);
  
}

class LengthAllNotesEvent extends NotesEvent {
  final int length;
  LengthAllNotesEvent(this.length);
}


