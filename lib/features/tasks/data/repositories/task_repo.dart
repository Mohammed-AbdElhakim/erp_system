import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/task_model.dart';

abstract class TaskRepo {
  Future<Either<Failure, TaskModel>> getTask();
}