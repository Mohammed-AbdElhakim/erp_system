import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/trial_cost_body_model.dart';
import '../models/trial_cost_model.dart';

abstract class TrialCostRepo {
  Future<Either<Failure, TrialCostModel>> getTrialCost({
    required TrialCostBodyModel trialCostBody,
  });
}
