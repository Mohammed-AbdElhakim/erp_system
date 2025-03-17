import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/body_request_daily_french_cash.dart';
import '../models/daily_french_cash_model.dart';

abstract class DailyFrenchCashRepo {
  Future<Either<Failure, DailyFrenchCashModel>> getDailyFrenchCash(
      {required BodyRequestDailyFrenchCash bodyRequestDailyFrenchCash});
}
