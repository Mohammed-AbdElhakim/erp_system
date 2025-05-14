import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/offer_master_model.dart';
import '../../../data/repositories/offer_master_repo.dart';

part 'get_offer_master_state.dart';

class GetOfferMasterCubit extends Cubit<GetOfferMasterState> {
  GetOfferMasterCubit(this.offerMasterRepo) : super(GetOfferMasterInitial());
  final OfferMasterRepo offerMasterRepo;

  Future<void> getOfferMaster() async {
    emit(GetOfferMasterLoading());
    Either<Failure, OfferMasterModel> result = await offerMasterRepo.getOfferMaster();
    result.fold((failure) {
      emit(GetOfferMasterFailure(failure.errorMassage));
    }, (headerList) {
      emit(GetOfferMasterSuccess(headerList));
    });
  }

  Future<void> changeOfferStatus({
    required int offerId,
    required int newStateId,
  }) async {
    // emit(GetOfferMasterLoading());
    Either<Failure, OfferMasterModel> result = await offerMasterRepo.changeOfferStatus(offerId: offerId, newStateId: newStateId);
    result.fold((failure) {
      emit(GetOfferMasterFailure(failure.errorMassage));
    }, (headerList) {
      emit(GetOfferMasterSuccess(headerList));
    });
  }

  Future<void> setOrder({
    required int offerId,
  }) async {
    // emit(GetOfferMasterLoading());
    Either<Failure, OfferMasterModel> result = await offerMasterRepo.setOrder(offerId: offerId);
    result.fold((failure) {
      emit(GetOfferMasterFailure(failure.errorMassage));
    }, (headerList) {
      emit(GetOfferMasterSuccess(headerList));
    });
  }
}
