import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/all_dropdown_model.dart';
import '../models/screen_model.dart';

abstract class AccountProfRepo {
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
  Future<Either<Failure, List<AllDropdownModel>>> getAllDropdownList({
    required int pageID,
  });
}
