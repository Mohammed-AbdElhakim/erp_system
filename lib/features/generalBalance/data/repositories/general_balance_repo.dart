import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/general_balance_body_model.dart';
import '../models/general_balance_model.dart';

abstract class GeneralBalanceRepo {
  Future<Either<Failure, List<GeneralBalanceModel>>> getGeneralBalance({
    required GeneralBalanceBodyModel generalBalanceBodyModel,
  });
}
