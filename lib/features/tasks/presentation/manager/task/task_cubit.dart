import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:erp_system/features/tasks/data/models/task_model.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
}
