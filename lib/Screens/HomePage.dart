import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:keep_notes/Bloc/Notes/notes_bloc.dart';
import 'package:keep_notes/Models/NoteModels.dart';
import 'package:keep_notes/Screens/AddNotePage.dart';
import 'package:keep_notes/Screens/ShowNotePage.dart';
import 'package:keep_notes/Widgets/TextFrave.dart';


class HomePage extends StatefulWidget{  
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  @override
  void initState() { 
    super.initState();
  }

  var box = Hive.box<NoteModels>('keepNote');

  bool isListView = true;

  @override
  Widget build(BuildContext context)
  {
    final noteBloc = BlocProvider.of<NotesBloc>(context);

    return Scaffold(
      backgroundColor: Color(0xffF2F3F7),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffF2F3F7),
        elevation: 0,
        title: TextFrave(text: 'Keep Note', fontWeight: FontWeight.w500, fontSize: 21 ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
                noteBloc.add(ChangedListToGrid(isListView));

                isListView =! isListView;
            }, 
            icon: BlocBuilder<NotesBloc, NotesState>(
              builder: (_, state) => state.isList ? Icon(Icons.table_rows, color: Colors.black) : Icon(Icons.grid_view_rounded, color: Colors.black),
            )
          )
        ],
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (_, Box box, __){

            if( box.values.isEmpty ){
              return Center(
                child: TextFrave(text: 'Without Notes', color: Colors.blue ),
              );
            }
            
            return BlocBuilder<NotesBloc, NotesState>(
              builder: (_, state) {

                return state.isList 
                ? ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    itemCount: box.values.length,
                    itemBuilder: (_, i){
                
                      NoteModels notes = box.getAt(i);
                
                      return BlocBuilder<NotesBloc, NotesState>(
                        builder: (_, state) =>  state.isList ? _ListNotes(note: notes, index: i) : _GridViewNote(note: notes, index: i)
                      );
                    }
                )
              : GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      childAspectRatio: 2 / 2,
                      crossAxisSpacing: 10,
                      maxCrossAxisExtent: 200,
                      mainAxisExtent: 250
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    itemCount: box.values.length,
                    itemBuilder: (_, i){
                
                      NoteModels notes = box.getAt(i);
                
                      return BlocBuilder<NotesBloc, NotesState>(
                        builder: (_, state) =>  state.isList ? _ListNotes(note: notes, index: i) : _GridViewNote(note: notes, index: i)
                      );
                
                    },
                  );

              } 
            );

          },
        ),
      ),
      floatingActionButton: InkWell(
        borderRadius: BorderRadius.circular(50.0),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AddNotePage())),
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Color(0xff1977F3),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.blue, blurRadius: 10, spreadRadius: -5.0)
            ]
          ),
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _ListNotes extends StatelessWidget {

  final NoteModels note;
  final int index;

  const _ListNotes({required this.note, required this.index});

  String getTimeString(date){

    final dateTime = DateTime.parse(date);
    final format = DateFormat('d-m-y - HH:mm');

    return format.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {

    final size =  MediaQuery.of(context).size;

    final noteBloc = BlocProvider.of<NotesBloc>(context);

    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ShowNotePage(note: note, index: index ))),
      child: Dismissible(
        key: Key(note.title!),
        background: Container(),
        direction: DismissDirection.endToStart,
        secondaryBackground: Container(
          padding: EdgeInsets.only(right: 35.0),
          margin: EdgeInsets.only(bottom: 15.0),
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), bottomRight: Radius.circular(20.0))
          ),
          child: Icon(Icons.delete_sweep_rounded, color: Colors.white, size: 40),
        ),
        onDismissed: (direction) => noteBloc.add( DeleteNoteEvent(index) ),
        child: Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.only(bottom: 15.0),
          height: 110,
          width: size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFrave(text: note.title.toString(), fontWeight: FontWeight.w600 ),
                  TextFrave(text: note.category!, fontSize: 16, color: Colors.blueGrey ),
                ],
              ),
              SizedBox(height: 10.0),
              Wrap(
                children: [
                  TextFrave(
                    text: note.body.toString(), 
                    fontSize: 16, 
                    color: Colors.grey,
                    textOverflow: TextOverflow.ellipsis,
                  )
                ],
              ),
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFrave(text: getTimeString(note.created.toString()), fontSize: 16, color: Colors.grey ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.circle, color: Color(note.color!), size: 15)
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


class _GridViewNote extends StatelessWidget {
  
  final NoteModels note;
  final int index;

  const _GridViewNote({required this.note, required this.index});

  String getTimeString(date){

    final dateTime = DateTime.parse(date);
    final format = DateFormat('d-m-y');

    return format.format(dateTime);
  }

  @override
  Widget build(BuildContext context)
  {   
    final noteBloc = BlocProvider.of<NotesBloc>(context);
    
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ShowNotePage(note: note, index: index ))),
      child: Dismissible(
        key: Key(note.title!),
        direction: DismissDirection.up,
        background: Container(),
        secondaryBackground: Container(
          padding: EdgeInsets.only(bottom: 35.0),
          margin: EdgeInsets.only(bottom: 15.0),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0))
          ),
          child: Icon(Icons.delete, color: Colors.white, size: 40),
        ),
        onDismissed: (direction) => noteBloc.add( DeleteNoteEvent(index) ),
        child: Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.only(bottom: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: TextFrave(text: note.title.toString(), fontWeight: FontWeight.w600 )
              ),
              SizedBox(height: 10.0),
              Expanded(
                child: Container(
                  child: TextFrave(
                    text: note.body.toString(), 
                    fontSize: 16, 
                    color: Colors.grey,
                    textOverflow: TextOverflow.ellipsis,
                    maxLine: 8,
                  )
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFrave(text: getTimeString(note.created.toString()), fontSize: 16, color: Colors.grey ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.circle, color: Color(note.color!), size: 15)
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}



