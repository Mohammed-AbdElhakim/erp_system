part of 'get_offer_master_cubit.dart';

sealed class GetOfferMasterState extends Equatable {
  const GetOfferMasterState();

  @override
  List<Object> get props => [];
}

final class GetOfferMasterInitial extends GetOfferMasterState {}

final class GetOfferMasterLoading extends GetOfferMasterState {}

final class GetOfferMasterFailure extends GetOfferMasterState {
  final String errorMassage;

  const GetOfferMasterFailure(this.errorMassage);
}

final class GetOfferMasterSuccess extends GetOfferMasterState {
  final OfferMasterModel offerMasterModel;

  const GetOfferMasterSuccess(this.offerMasterModel);
}
