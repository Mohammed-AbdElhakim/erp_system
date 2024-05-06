import 'package:dartz/dartz.dart';
import 'package:erp_system/core/errors/failures.dart';
import 'package:erp_system/features/tasks/data/models/task_model.dart';

import '../../../../core/utils/api_service.dart';
import 'task_repo.dart';

class TaskRepoImpl implements TaskRepo {
  final ApiService apiService;

  TaskRepoImpl(this.apiService);

  @override
  Future<Either<Failure, TaskModel>> getTask() {
    // TODO: implement getTask
    throw UnimplementedError();
  }
}
