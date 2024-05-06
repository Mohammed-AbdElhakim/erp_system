part of 'move_task_cubit.dart';

sealed class MoveTaskState extends Equatable {
  const MoveTaskState();
  @override
  List<Object> get props => [];
}

final class MoveTaskInitial extends MoveTaskState {}

final class MoveTaskLoading extends MoveTaskState {}

final class MoveTaskFailure extends MoveTaskState {
  final String errorMassage;

  const MoveTaskFailure(this.errorMassage);
}

final class MoveTaskToProgress extends MoveTaskState {}

final class MoveTaskToToDo extends MoveTaskState {}

final class MoveTaskToUnderRevision extends MoveTaskState {}

final class MoveTaskToDone extends MoveTaskState {}
