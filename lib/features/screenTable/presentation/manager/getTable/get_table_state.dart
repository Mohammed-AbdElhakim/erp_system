part of 'get_table_cubit.dart';

sealed class GetTableState extends Equatable {
  const GetTableState();
  @override
  List<Object> get props => [];
}

final class GetScreenInitial extends GetTableState {}

final class GetScreenLoading extends GetTableState {}

final class GetScreenFailure extends GetTableState {
  final String errorMassage;

  const GetScreenFailure(this.errorMassage);
}

final class GetScreenSuccess extends GetTableState {
  final ScreenModel screenModel;

  const GetScreenSuccess(this.screenModel);
}
