part of 'notes_bloc.dart';

abstract class NoteEvent {
  NoteEvent({this.notes});
  List<Note>? notes;
}

class GetAllNoteEvent extends NoteEvent {}

class CreateNoteEvent extends NoteEvent {
  CreateNoteEvent(this.note);

  Note note;
}

class DeleteNoteEvent extends NoteEvent {
  DeleteNoteEvent(this.id);
  int id;
}

class UpdateNoteEvent extends NoteEvent {
  UpdateNoteEvent(this.note);
  Note note;
}

class DeleteAllNoteEvent extends NoteEvent {}

class ShowNoteInGridEvent extends NoteEvent {}

class ShowNoteInListEvent extends NoteEvent {}

class CloseDBEvent extends NoteEvent {}
