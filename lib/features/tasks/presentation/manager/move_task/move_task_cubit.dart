import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'move_task_state.dart';

class MoveTaskCubit extends Cubit<MoveTaskState> {
  MoveTaskCubit() : super(MoveTaskInitial());
}
