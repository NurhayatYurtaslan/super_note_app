import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_note_app/app/models/note.dart';
import 'package:super_note_app/app/repository/repository.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository _noteRepository = NoteRepository();
  NoteBloc() : super(NoteInitialState()) {
    on<GetAllNoteEvent>((event, emit) async {
      emit.call(NoteLoadingState());
      try {
        List<Note> notes = await _noteRepository.getAllNotes();
        emit.call(NoteLoadedState(notes));
      } catch (e) {
        emit.call(ErrorNoteState(e.toString()));
      }
    });

    on<DeleteAllNoteEvent>((event, emit) {
      _noteRepository.deleteAllNotes();
      emit.call(AllNoteState());
    });

    on<ShowNoteInGridEvent>((event, emit) {
      emit.call(ShowNoteInViewState(true));
    });

    on<ShowNoteInListEvent>((event, emit) {
      emit.call(ShowNoteInViewState(false));
    });

    on<CreateNoteEvent>(((event, emit) async {
      await _noteRepository.createNote(event.note);
      List<Note> notes = await _noteRepository.getAllNotes();
      emit.call(CreateNoteState(notes));
    }));

    on<DeleteNoteEvent>(((event, emit) async {
      await _noteRepository.deleteNoteById(event.id);
      List<Note> notes = await _noteRepository.getAllNotes();
      emit.call(DeleteNoteState(notes));
    }));

    on<UpdateNoteEvent>(((event, emit) async {
      await _noteRepository.updateNoteById(event.note);
      List<Note> notes = await _noteRepository.getAllNotes();
      emit.call(UpdateNoteState(notes));
    }));

    on<CloseDBEvent>(((event, emit) async {
      await _noteRepository.closeDB();
    }));
  }
}
