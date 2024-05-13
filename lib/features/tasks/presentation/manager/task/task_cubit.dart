import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/task_model.dart';
import '../../../data/repositories/task_repo.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit(this.taskRepo) : super(TaskInitial());
  final TaskRepo taskRepo;
  Future<void> getTasks() async {
    emit(TaskLoading());
    Either<Failure, List<TaskModel>> result = await taskRepo.getTask();
    result.fold((failure) {
      emit(TaskFailure(failure.errorMassage));
    }, (tasks) {
      emit(TaskSuccess(tasks));
    });
  }
}
