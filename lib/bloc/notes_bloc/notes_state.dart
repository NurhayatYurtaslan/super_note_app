part of 'notes_bloc.dart';

abstract class NoteState {}

class NoteInitialState extends NoteState {}

class NoteLoadingState extends NoteState {}

class NoteLoadedState extends NoteState {
  NoteLoadedState(this.notes);
  List<Note> notes;
}

class AllNoteState extends NoteState {}

class DeleteNoteState extends NoteState {
  DeleteNoteState(this.notes);
  List<Note> notes;
}

class AllNotesDeletedState extends NoteState {}
class CreateNoteState extends NoteState {
  CreateNoteState(this.notes);

  List<Note> notes;
}

class UpdateNoteState extends NoteState {
  UpdateNoteState(this.notes);
  List<Note> notes;
}

class ErrorNoteState extends NoteState {
  ErrorNoteState(this.message);
  String message;
}

class ShowNoteInViewState extends NoteState {
  ShowNoteInViewState(this.inGrid);
  bool inGrid = true;
}
