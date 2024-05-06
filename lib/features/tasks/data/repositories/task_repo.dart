import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/task_model.dart';

abstract class TaskRepo {
  Future<Either<Failure, List<TaskModel>>> getTask();
  Future<Either<Failure, TaskModel>> getTaskById(String id);
}
