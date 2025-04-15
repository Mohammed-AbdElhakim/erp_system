part of 'notes_cubit.dart';

sealed class NotesState extends Equatable {
  const NotesState();
  @override
  List<Object> get props => [];
}

final class NotesInitial extends NotesState {}

final class NotesLoading extends NotesState {}

final class NotesFailure extends NotesState {
  final String errorMassage;

  const NotesFailure(this.errorMassage);
}


final class AllNotesSuccess extends NotesState {
  final List<NoteModel> listNote;

  const AllNotesSuccess(this.listNote);
}


final class AddNotesSuccess extends NotesState {
}
final class UpdateNotesSuccess extends NotesState {
}
final class DeleteNotesSuccess extends NotesState {
}