part of 'add_edit_expenses_cubit.dart';

sealed class AddEditExpensesState extends Equatable {
  const AddEditExpensesState();
  @override
  List<Object> get props => [];
}

final class AddEditExpensesInitial extends AddEditExpensesState {}

final class AddEditExpensesLoading extends AddEditExpensesState {}

final class AddEditExpensesFailure extends AddEditExpensesState {
  final String errorMassage;

  const AddEditExpensesFailure(this.errorMassage);
}

final class AddEditExpensesSuccess extends AddEditExpensesState {}
