import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/note_model.dart';
import '../../../data/repositories/task_repo.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit(this.taskRepo) : super(NotesInitial());
  final TaskRepo taskRepo;

  Future<void> getAllNoteList({required int idTask}) async {
    emit(NotesLoading());
    Either<Failure, List<NoteModel>> result = await taskRepo.listOfNotes(taskID: idTask);
    result.fold((failure) {
      emit(NotesFailure(failure.errorMassage));
    }, (data) {
      emit(AllNotesSuccess(data));
    });
  }

  Future<void> addNewNotes({
    required String note,
    required int taskID,}) async {
    emit(NotesLoading());
    Either<Failure, Map<String,dynamic>> result = await taskRepo.addNote(taskID: taskID, note: note);
    result.fold((failure) {
      emit(NotesFailure(failure.errorMassage));
    }, (data) {
      emit(AddNotesSuccess());
    });
  }
  Future<void> updateNotes({
  required  int taskID,
  required  int empID,
  required  int tNID,
  required String dateNote,
  required String note}) async {
    emit(NotesLoading());
    Either<Failure, Map<String,dynamic>> result = await taskRepo.updateNote(
        taskID: taskID, note: note,empID:empID ,dateNote:dateNote ,tNID:tNID );
    result.fold((failure) {
      emit(NotesFailure(failure.errorMassage));
    }, (data) {
      emit(AddNotesSuccess());
    });
  }

  Future<void> deleteNotes({required int noteID}) async {
    emit(NotesLoading());
    Either<Failure, String> result = await taskRepo.deleteNote(noteID:noteID );
    result.fold((failure) {
      emit(NotesFailure(failure.errorMassage));
    }, (data) {
      emit(DeleteNotesSuccess());
    });
  }



}
