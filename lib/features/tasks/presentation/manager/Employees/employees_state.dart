part of 'employees_cubit.dart';

sealed class EmployeesState extends Equatable {
  const EmployeesState();
  @override
  List<Object> get props => [];
}

final class EmployeesInitial extends EmployeesState {}

final class EmployeesLoading extends EmployeesState {}

final class EmployeesFailure extends EmployeesState {
  final String errorMassage;

  const EmployeesFailure(this.errorMassage);
}


final class EmployeesSuccess extends EmployeesState {
  final EmployeesModel employees;

  const EmployeesSuccess(this.employees);
}

final class GetEmployeesSuccess extends EmployeesState {
  final List<GetEmployeesModel> employeesList;

  const GetEmployeesSuccess(this.employeesList);
}
final class AddEmployeesSuccess extends EmployeesState {

}
final class DeleteEmployeesSuccess extends EmployeesState {

}