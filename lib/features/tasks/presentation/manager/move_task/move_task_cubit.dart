import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/repositories/task_repo.dart';

part 'move_task_state.dart';

class MoveTaskCubit extends Cubit<MoveTaskState> {
  MoveTaskCubit(this.taskRepo) : super(MoveTaskInitial());
  final TaskRepo taskRepo;

  Future<void> moveTaskToToDo(String id) async {
    emit(MoveTaskLoading());
    Either<Failure, String> result = await taskRepo.moveTaskToToDo(id);
    result.fold((failure) {
      emit(MoveTaskFailure(failure.errorMassage));
    }, (tasks) {
      emit(MoveTaskToToDo());
    });
  }

  Future<void> moveTaskToProgress(String id) async {
    emit(MoveTaskLoading());
    Either<Failure, String> result = await taskRepo.moveTaskToProgress(id);
    result.fold((failure) {
      emit(MoveTaskFailure(failure.errorMassage));
    }, (tasks) {
      emit(MoveTaskToProgress());
    });
  }

  Future<void> moveTaskToUnderRevision(String id) async {
    emit(MoveTaskLoading());
    Either<Failure, String> result = await taskRepo.moveTaskToUnderRevision(id);
    result.fold((failure) {
      emit(MoveTaskFailure(failure.errorMassage));
    }, (tasks) {
      emit(MoveTaskToUnderRevision());
    });
  }

  Future<void> moveTaskToDone(String id) async {
    emit(MoveTaskLoading());
    Either<Failure, String> result = await taskRepo.moveTaskToDone(id);
    result.fold((failure) {
      emit(MoveTaskFailure(failure.errorMassage));
    }, (tasks) {
      emit(MoveTaskToDone());
    });
  }
}
