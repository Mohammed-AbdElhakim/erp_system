part of 'task_cubit.dart';

sealed class TaskState extends Equatable {
  const TaskState();
  @override
  List<Object> get props => [];
}

final class TaskInitial extends TaskState {}

final class TaskLoading extends TaskState {}

final class TaskFailure extends TaskState {
  final String errorMassage;

  const TaskFailure(this.errorMassage);
}

final class TaskSuccess extends TaskState {
  final List<TaskModel> taskList;

  const TaskSuccess(this.taskList);
}
