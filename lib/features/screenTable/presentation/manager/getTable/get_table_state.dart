part of 'get_table_cubit.dart';

sealed class GetTableState extends Equatable {
  const GetTableState();
  @override
  List<Object> get props => [];
}

final class GetTableInitial extends GetTableState {}

final class GetTableLoading extends GetTableState {}

final class GetTableFailure extends GetTableState {
  final String errorMassage;

  const GetTableFailure(this.errorMassage);
}

final class GetTableSuccess extends GetTableState {
  final ScreenModel screenModel;

  const GetTableSuccess(this.screenModel);
}
