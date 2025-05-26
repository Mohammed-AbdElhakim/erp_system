part of 'bills_cubit.dart';

sealed class BillsState extends Equatable {
  const BillsState();

  @override
  List<Object> get props => [];
}

final class BillsInitial extends BillsState {}

final class BillsLoading extends BillsState {}

final class BillsFailure extends BillsState {
  final String errorMassage;

  const BillsFailure(this.errorMassage);
}

final class BillsSuccess extends BillsState {
  final List<BillsHeaderModel> billsHeaderList;
  final List<BillsDataModel> billsDataList;

  const BillsSuccess({required this.billsHeaderList, required this.billsDataList});
}
