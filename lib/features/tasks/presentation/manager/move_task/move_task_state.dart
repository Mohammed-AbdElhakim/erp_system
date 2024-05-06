part of 'move_task_cubit.dart';

sealed class MoveTaskState extends Equatable {
  const MoveTaskState();
}

final class MoveTaskInitial extends MoveTaskState {
  @override
  List<Object> get props => [];
}
