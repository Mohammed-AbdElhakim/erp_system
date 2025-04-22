part of 'data_global_cubit.dart';

sealed class DataGlobalState extends Equatable {
  const DataGlobalState();

  @override
  List<Object> get props => [];
}

final class DataGlobalInitial extends DataGlobalState {}

final class DataGlobalLoading extends DataGlobalState {}

final class DataGlobalFailure extends DataGlobalState {
  final String errorMassage;

  const DataGlobalFailure(this.errorMassage);
}

final class DataGlobalSuccess extends DataGlobalState {
  final Map<String, dynamic> data;

  const DataGlobalSuccess(this.data);
}
