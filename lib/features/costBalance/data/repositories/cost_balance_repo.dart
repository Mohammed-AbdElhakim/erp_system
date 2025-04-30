import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/cost_balance_model.dart';

abstract class CostBalanceRepo {
  Future<Either<Failure, List<CostBalanceModel>>> getCostBalance({
    required Map<String, dynamic> bodyRequest,
  });
}
