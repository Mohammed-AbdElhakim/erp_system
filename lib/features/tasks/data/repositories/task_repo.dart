import 'package:dartz/dartz.dart';
import 'package:erp_system/features/tasks/data/models/note_model.dart';

import '../../../../core/errors/failures.dart';
import '../models/add_new_time_model.dart';
import '../models/all_time_model.dart';
import '../models/employees_model.dart';
import '../models/get_employees_model.dart';
import '../models/progress_model.dart';
import '../models/task_model.dart';

abstract class TaskRepo {
  Future<Either<Failure, List<TaskModel>>> getTask();
  Future<Either<Failure, TaskModel>> getTaskById(String id);
  Future<Either<Failure, String>> moveTaskToToDo(String id);
  Future<Either<Failure, String>> moveTaskToProgress(String id);
  Future<Either<Failure, String>> moveTaskToUnderRevision(String id);
  Future<Either<Failure, String>> moveTaskToDone(String id);
  Future<Either<Failure, String>> deleteTask(String id);
  Future<Either<Failure, EmployeesModel>> employees();

  Future<Either<Failure, String>> addNewEmployees(String idTask,String idEmployee);
  Future<Either<Failure, String>> deleteEmployees(String idTask,String idEmployee);
  Future<Either<Failure, List<GetEmployeesModel>>> getTaskEmployees(String idTask);

  Future<Either<Failure, List<AllTimeModel>>> getAllTime(String idTask);
  Future<Either<Failure, String>> deleteTime(String idTime);
  Future<Either<Failure, AddNewTimeModel>> addNewTime(
      {required String description, required String requestedDate,
        required int tTLID,required  int taskID});

  Future<Either<Failure,List<NoteModel>>> listOfNotes({required  int taskID});
  Future<Either<Failure,String>> deleteNote({required  int noteID});
  Future<Either<Failure,Map<String,dynamic>>> addNote({required  int taskID,required String note});
  Future<Either<Failure,Map<String,dynamic>>> updateNote(
      {
        required  int taskID,
        required  int empID,
        required  int tNID,
        required String dateNote,
        required String note});


  Future<Either<Failure,List<ProgressModel>>> listOfProgress({required  int taskID});
  Future<Either<Failure,String>> deleteProgress({required  int progressID});
  Future<Either<Failure,Map<String,dynamic>>> addNewProgress({
    required  int taskID,
    required  double? progress,
    required String note,
    required String dateFrom,
    required String dateTo

  });
  Future<Either<Failure,Map<String,dynamic>>> updateProgress(
      {
        required  int empID,
        required  int taskID,
        required  int tPID,
        required  double? progress,
        required String note,
        required String dateFrom,
        required String dateTo,
        required String date
      });



}
