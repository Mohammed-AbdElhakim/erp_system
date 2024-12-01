
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/dashboard_model.dart';

abstract class DashboardRepo {
  Future<Either<Failure, DashboardModel>> getDashboard();
}