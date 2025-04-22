part of 'table_data_cubit.dart';

sealed class GetTableDataState extends Equatable {
  const GetTableDataState();

  @override
  List<Object> get props => [];
}

final class GetTableDataInitial extends GetTableDataState {}

final class GetTableDataLoading extends GetTableDataState {}

final class GetTableDataFailure extends GetTableDataState {
  final String errorMassage;

  const GetTableDataFailure(this.errorMassage);
}

final class GetTableDataSuccess extends GetTableDataState {
  final TableDataModel data;
  final int numberPage;
  final int dropdownValue;

  const GetTableDataSuccess({required this.data, required this.numberPage, required this.dropdownValue});
}
