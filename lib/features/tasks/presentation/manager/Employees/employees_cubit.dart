import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/employees_model.dart';
import '../../../data/models/get_employees_model.dart';
import '../../../data/repositories/task_repo.dart';

part 'employees_state.dart';

class EmployeesCubit extends Cubit<EmployeesState> {
  EmployeesCubit(this.taskRepo) : super(EmployeesInitial());
  final TaskRepo taskRepo;

  Future<void> getEmployees() async {
    emit(EmployeesLoading());
    Either<Failure, EmployeesModel> result = await taskRepo.employees();
    result.fold((failure) {
      emit(EmployeesFailure(failure.errorMassage));
    }, (data) {
      emit(EmployeesSuccess(data));
    });
  }
  Future<void> getEmployeesList({required String idTask}) async {
    emit(EmployeesLoading());
    Either<Failure, List<GetEmployeesModel>> result = await taskRepo.getTaskEmployees(idTask);
    result.fold((failure) {
      emit(EmployeesFailure(failure.errorMassage));
    }, (data) {
      emit(GetEmployeesSuccess(data));
    });
  }
  Future<void> addNewEmployees({required String idTask,
  required String idEmployee}) async {
    emit(EmployeesLoading());
    Either<Failure, String> result = await taskRepo.addNewEmployees(idTask, idEmployee);
    result.fold((failure) {
      emit(EmployeesFailure(failure.errorMassage));
    }, (data) {
      emit(AddEmployeesSuccess());
    });
  }
  Future<void> deleteEmployees({required String idTask,
    required String idEmployee}) async {
    emit(EmployeesLoading());
    Either<Failure, String> result = await taskRepo.deleteEmployees(idTask, idEmployee);
    result.fold((failure) {
      emit(EmployeesFailure(failure.errorMassage));
    }, (data) {
      emit(DeleteEmployeesSuccess());
    });
  }
  Future<void> getEmployeesTaskListAndGetEmployees({required String idTask}) async {
    getEmployees();
    getEmployeesList(idTask: idTask);

  }


}
