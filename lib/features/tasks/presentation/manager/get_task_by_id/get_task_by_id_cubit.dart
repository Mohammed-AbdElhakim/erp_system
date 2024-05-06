import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/task_model.dart';
import '../../../data/repositories/task_repo.dart';

part 'get_task_by_id_state.dart';

class GetTaskByIdCubit extends Cubit<GetTaskByIdState> {
  GetTaskByIdCubit(this.taskRepo) : super(GetTaskByIdInitial());
  final TaskRepo taskRepo;
  Future<void> getTaskById(String id) async {
    emit(GetTaskByIdLoading());
    Either<Failure, TaskModel> result = await taskRepo.getTaskById(id);
    result.fold((failure) {
      emit(GetTaskByIdFailure(failure.errorMassage));
    }, (tasks) {
      emit(GetTaskByIdSuccess(tasks));
    });
  }
}
