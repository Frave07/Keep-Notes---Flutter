part of 'notes_bloc.dart';

@immutable
class NotesState {

  final int color;
  final String category;
  final Color colorCategory;
  final bool isList;

  const NotesState({
    this.color = 0xff1977F3, 
    this.category = 'No list',
    this.colorCategory = Colors.grey,
    this.isList = true
  });

  NotesState copyWith({ int? color, String? category, Color? colorCategory, bool? isList })
    => NotesState(
      color: color ?? this.color,
      category: category ?? this.category,
      colorCategory: colorCategory ?? this.colorCategory,
      isList: isList ?? this.isList
  );

}

