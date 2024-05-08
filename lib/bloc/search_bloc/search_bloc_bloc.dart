import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_note_app/models/note.dart';
import 'package:super_note_app/repository/repository.dart';

part 'search_bloc_event.dart';
part 'search_bloc_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final NoteRepository _notesRepository = NoteRepository();
  SearchBloc() : super(SearchInitialState()) {
    on<SearchGetAllNotesEvent>((event, emit) async {
      emit.call(SearchLoadingListState());
      try {
        List<Note> notes = await _notesRepository.getAllNotes();
        emit.call(SearchLoadedListState(notes));
      } catch (e) {
        emit.call(SearchErrorState(e.toString()));
      }
    });

    on<SearchGetNotesWithTextEvent>((event, emit) {
      List<Note> notesList = event.notesList;
      List<Note> filteredList = [];
      filteredList = notesList
          .where((note) =>
              note.title!.toLowerCase().contains(event.text.toLowerCase()))
          .toList();
      if (event.text.isEmpty) {
        emit.call(SearchGetNotesWithTextState(notesList));
      } else {
        emit.call(SearchGetNotesWithTextState(filteredList));
      }
    });
  }
}
