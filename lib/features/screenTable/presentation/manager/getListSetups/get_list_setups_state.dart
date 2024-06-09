part of 'get_list_setups_cubit.dart';

sealed class GetListSetupsState extends Equatable {
  const GetListSetupsState();
  @override
  List<Object> get props => [];
}

final class GetListSetupsInitial extends GetListSetupsState {}

final class GetListSetupsLoading extends GetListSetupsState {}

final class GetListSetupsFailure extends GetListSetupsState {
  final String errorMassage;

  const GetListSetupsFailure(this.errorMassage);
}

final class GetListSetupsSuccess extends GetListSetupsState {
  final List<ItemListSetupModel> listSetupModel;

  const GetListSetupsSuccess(this.listSetupModel);
}
