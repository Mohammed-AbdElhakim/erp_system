import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/offer_master_model.dart';

abstract class OfferMasterRepo {
  Future<Either<Failure, OfferMasterModel>> getOfferMaster();

  Future<Either<Failure, OfferMasterModel>> changeOfferStatus({
    required int offerId,
    required int newStateId,
  });

  Future<Either<Failure, OfferMasterModel>> setOrder({
    required int offerId,
  });
}
