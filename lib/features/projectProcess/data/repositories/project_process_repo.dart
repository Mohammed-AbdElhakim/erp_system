import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/all_dropdown_model.dart';
import '../models/header_model.dart';
import '../models/screen_model.dart';

abstract class ProjectProcessRepo {
  Future<Either<Failure, ScreenModel>> getTable({
    required int pageId,
    required bool employee,
    required bool isdesc,
    required int limit,
    required int offset,
    required String orderby,
    required String statment,
    required String selectcolumns,
    required bool isDepartment,
    required String departmentName,
    required int authorizationID,
    required String viewEmployeeColumn,
  });
  Future<Either<Failure, List<HeaderModel>>> getHeaderTable({
    required String listName,
  });
  Future<Either<Failure, List<AllDropdownModel>>> getAllDropdownList({
    required int pageID,
  });

  Future<Either<Failure, String>> add({
    required String controllerName,
    required Map<String, dynamic> body,
  });

  Future<Either<Failure, Map<String, dynamic>>> getTableProjectProcess(
      {required Map<String, dynamic> objectData, required String link});
}
