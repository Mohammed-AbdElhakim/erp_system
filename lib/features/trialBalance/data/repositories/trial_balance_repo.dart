import 'package:dartz/dartz.dart';
import 'package:erp_system/features/trialBalance/data/models/trial_balance_body_model.dart';
import 'package:erp_system/features/trialBalance/data/models/trial_balance_model.dart';

import '../../../../core/errors/failures.dart';

abstract class TrialBalanceRepo {
  Future<Either<Failure, List<TrialBalanceModel>>> getTrialBalance({
    required TrialBalanceBodyModel trialBalanceBody,
  });
}
