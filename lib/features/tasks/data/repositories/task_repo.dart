import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/task_model.dart';

abstract class TaskRepo {
  Future<Either<Failure, List<TaskModel>>> getTask();
  Future<Either<Failure, TaskModel>> getTaskById(String id);
  Future<Either<Failure, String>> moveTaskToToDo(String id);
  Future<Either<Failure, String>> moveTaskToProgress(String id);
  Future<Either<Failure, String>> moveTaskToUnderRevision(String id);
  Future<Either<Failure, String>> moveTaskToDone(String id);
}
