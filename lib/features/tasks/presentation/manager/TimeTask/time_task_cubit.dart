import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:erp_system/features/tasks/data/models/add_new_time_model.dart';
import 'package:erp_system/features/tasks/data/models/all_time_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/repositories/task_repo.dart';

part 'time_task_state.dart';

class TimeTaskCubit extends Cubit<TimeTaskState> {
  TimeTaskCubit(this.taskRepo) : super(TimeTaskInitial());
  final TaskRepo taskRepo;

  Future<void> getTimeTaskList({required String idTask}) async {
    emit(TimeTaskLoading());
    Either<Failure, List<AllTimeModel>> result = await taskRepo.getAllTime(idTask);
    result.fold((failure) {
      emit(TimeTaskFailure(failure.errorMassage));
    }, (data) {
      emit(AllTimeTaskSuccess(data));
    });
  }

  Future<void> addNewTimeTask({
    required String description,
    required String requestedDate,
    required int tTLID,
    required int taskID,}) async {
    emit(TimeTaskLoading());
    Either<Failure, AddNewTimeModel> result = await taskRepo.addNewTime(description:description ,
    requestedDate:requestedDate ,
    taskID: taskID,
    tTLID: tTLID,);
    result.fold((failure) {
      emit(TimeTaskFailure(failure.errorMassage));
    }, (data) {
      emit(AddTimeTaskSuccess(data));
    });
  }

  Future<void> deleteTimeTask({required String idTime}) async {
    emit(TimeTaskLoading());
    Either<Failure, String> result = await taskRepo.deleteTime(idTime);
    result.fold((failure) {
      emit(TimeTaskFailure(failure.errorMassage));
    }, (data) {
      emit(DeleteTimeTaskSuccess());
    });
  }



}
