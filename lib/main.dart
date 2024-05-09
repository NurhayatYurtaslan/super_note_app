import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_note_app/bloc/notes_bloc/notes_bloc.dart';
import 'package:super_note_app/bloc/search_bloc/search_bloc_bloc.dart';
import 'package:super_note_app/core/constants/theme_constants.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<NoteBloc>(
          create: (context) => NoteBloc()..add(GetAllNoteEvent()),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc()..add(SearchGetAllNotesEvent()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super Note App',
      theme: notesTheme,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
