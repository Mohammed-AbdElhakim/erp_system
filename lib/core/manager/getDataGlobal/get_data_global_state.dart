part of 'get_data_global_cubit.dart';

sealed class GetDataGlobalState extends Equatable {
  const GetDataGlobalState();

  @override
  List<Object> get props => [];
}

final class GetDataGlobalInitial extends GetDataGlobalState {}

final class GetDataGlobalLoading extends GetDataGlobalState {}

final class GetDataGlobalFailure extends GetDataGlobalState {
  final String errorMassage;

  const GetDataGlobalFailure(this.errorMassage);
}

final class GetDataGlobalSuccess extends GetDataGlobalState {
  final Map<String, dynamic> dataGlobal;

  const GetDataGlobalSuccess(this.dataGlobal);
}
