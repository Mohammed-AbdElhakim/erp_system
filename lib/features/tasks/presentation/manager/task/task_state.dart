part of 'task_cubit.dart';

sealed class TaskState extends Equatable {
  const TaskState();
}

final class TaskInitial extends TaskState {
  @override
  List<Object> get props => [];
}
