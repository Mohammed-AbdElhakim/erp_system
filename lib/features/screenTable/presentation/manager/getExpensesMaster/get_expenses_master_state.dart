part of 'get_expenses_master_cubit.dart';

sealed class GetExpensesMasterState extends Equatable {
  const GetExpensesMasterState();
  @override
  List<Object> get props => [];
}

final class GetExpensesMasterInitial extends GetExpensesMasterState {}

final class GetExpensesMasterLoading extends GetExpensesMasterState {}

final class GetExpensesMasterFailure extends GetExpensesMasterState {
  final String errorMassage;

  const GetExpensesMasterFailure(this.errorMassage);
}

final class GetExpensesMasterSuccess extends GetExpensesMasterState {
  final Map<String, dynamic> data;

  const GetExpensesMasterSuccess(this.data);
}
