import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:erp_system/features/tasks/data/models/task_model.dart';
import 'package:erp_system/features/tasks/data/repositories/task_repo.dart';

import '../../../../../core/errors/failures.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit(this.taskRepo) : super(TaskInitial());
  final TaskRepo taskRepo;
  Future<void> getTasks() async {
    emit(TaskLoading());
    Either<Failure, TaskModel> result = await taskRepo.getTask();
    result.fold((failure) {
      emit(TaskFailure(failure.errorMassage));
    }, (tasks) {
      emit(TaskSuccess(tasks));
    });
  }
}
