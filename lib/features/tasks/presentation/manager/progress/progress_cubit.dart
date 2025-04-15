import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/progress_model.dart';
import '../../../data/repositories/task_repo.dart';

part 'progress_state.dart';

class ProgressCubit extends Cubit<ProgressState> {
  ProgressCubit(this.taskRepo) : super(ProgressInitial());
  final TaskRepo taskRepo;

  Future<void> getAllProgressList({required int idTask}) async {
    emit(ProgressLoading());
    Either<Failure, List<ProgressModel>> result = await taskRepo.listOfProgress(taskID: idTask);
    result.fold((failure) {
      emit(ProgressFailure(failure.errorMassage));
    }, (data) {
      emit(AllProgressSuccess(data));
    });
  }

  Future<void> addNewProgress({
    required  int taskID,
    required  double? progress,
    required String note,
    required String dateFrom,
    required String dateTo}) async {
    emit(ProgressLoading());
    Either<Failure, Map<String,dynamic>> result = await taskRepo.addNewProgress
      (taskID: taskID, progress: progress, note: note, dateFrom: dateFrom, dateTo: dateTo);
    result.fold((failure) {
      emit(ProgressFailure(failure.errorMassage));
    }, (data) {
      emit(AddProgressSuccess());
    });
  }
  Future<void> updateProgress({
  required  int empID,
  required  int taskID,
  required  int tPID,
  required  double? progress,
  required String note,
  required String dateFrom,
  required String dateTo,
  required String date
}) async {
    emit(ProgressLoading());
    Either<Failure, Map<String,dynamic>> result = await taskRepo.updateProgress
      (empID: empID, taskID: taskID, tPID: tPID, progress: progress, note: note,
        dateFrom: dateFrom, dateTo: dateTo, date: date);
    result.fold((failure) {
      emit(ProgressFailure(failure.errorMassage));
    }, (data) {
      emit(AddProgressSuccess());
    });
  }

  Future<void> deleteProgress({required int progressID}) async {
    emit(ProgressLoading());
    Either<Failure, String> result = await taskRepo.deleteProgress(progressID:progressID );
    result.fold((failure) {
      emit(ProgressFailure(failure.errorMassage));
    }, (data) {
      emit(DeleteProgressSuccess());
    });
  }



}
