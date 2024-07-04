part of 'get_expenses_details_cubit.dart';

sealed class GetExpensesDetailsState extends Equatable {
  const GetExpensesDetailsState();
  @override
  List<Object> get props => [];
}

final class GetExpensesDetailsInitial extends GetExpensesDetailsState {}

final class GetExpensesDetailsLoading extends GetExpensesDetailsState {}

final class GetExpensesDetailsFailure extends GetExpensesDetailsState {
  final String errorMassage;

  const GetExpensesDetailsFailure(this.errorMassage);
}

final class GetExpensesDetailsSuccess extends GetExpensesDetailsState {
  final ExpensesDetailsModel expensesDetailsModel;

  const GetExpensesDetailsSuccess(this.expensesDetailsModel);
}
