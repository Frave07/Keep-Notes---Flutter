import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep_notes/Bloc/Notes/notes_bloc.dart';
import 'package:keep_notes/Widgets/ItemCategory.dart';
import 'package:keep_notes/Widgets/TextFrave.dart';

void showDialogBottomFrave(ctx){

  final noteBloc = BlocProvider.of<NotesBloc>(ctx);

  showModalBottomSheet(
    context: ctx,
    barrierColor: Colors.black26, 
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0))),
    builder: (context) 
      => Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          boxShadow: [
            BoxShadow(color: Colors.blue, blurRadius: 10, spreadRadius: -5.0)
          ]
        ),
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(50)
              ),
            ),
            const SizedBox(height: 15.0),
            const TextFrave(text: 'Select Category', fontSize: 18, isTitle: true ),
            const SizedBox(height: 5.0),
            const Divider(),
            ItemCategory(
              color: Colors.blue,
              text: 'Personal',
              onPressed: () => noteBloc.add( SelectedCategoryEvent('Personal', Colors.blue) ),
            ),
            ItemCategory(
              color: Colors.green,
              text: 'Friends',
              onPressed: () => noteBloc.add( SelectedCategoryEvent('Friends', Colors.green)),
            ),
            ItemCategory(
              color: Colors.purple,
              text: 'Work',
              onPressed: () => noteBloc.add( SelectedCategoryEvent('Work', Colors.purple)),
            ),
            ItemCategory(
              color: Colors.orange,
              text: 'Erands',
              onPressed: () => noteBloc.add( SelectedCategoryEvent('Erands', Colors.orange)),
            ),
            ItemCategory(
              color: Colors.grey,
              text: 'No list',
              onPressed: () => noteBloc.add( SelectedCategoryEvent('No list', Colors.grey))
            ),
          ],
        ),
      ),
  );

}
