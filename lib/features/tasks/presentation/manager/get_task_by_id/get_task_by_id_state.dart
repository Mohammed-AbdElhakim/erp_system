part of 'get_task_by_id_cubit.dart';

sealed class GetTaskByIdState extends Equatable {
  const GetTaskByIdState();
  @override
  List<Object> get props => [];
}

final class GetTaskByIdInitial extends GetTaskByIdState {}

final class GetTaskByIdLoading extends GetTaskByIdState {}

final class GetTaskByIdFailure extends GetTaskByIdState {
  final String errorMassage;

  const GetTaskByIdFailure(this.errorMassage);
}

final class GetTaskByIdSuccess extends GetTaskByIdState {
  final TaskModel taskModel;

  const GetTaskByIdSuccess(this.taskModel);
}
