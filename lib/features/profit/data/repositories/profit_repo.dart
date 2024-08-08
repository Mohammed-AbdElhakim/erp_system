import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/profit_body_model.dart';
import '../models/profit_model.dart';

abstract class ProfitRepo {
  Future<Either<Failure, List<ProfitModel>>> getProfit({
    required ProfitBodyModel profitBodyModel,
  });
}
