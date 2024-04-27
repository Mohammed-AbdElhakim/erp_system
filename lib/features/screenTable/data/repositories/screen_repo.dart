import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../models/dropdown_model/dropdown_model.dart';
import '../models/permission_model.dart';
import '../models/screen_model.dart';

abstract class ScreenRepo {
  Future<Either<Failure, ScreenModel>> getTable({
    required String pageId,
    required bool employee,
    required bool isdesc,
    required int limit,
    required int offset,
    required String orderby,
    required String statment,
    required String selectcolumns,
  });
  Future<Either<Failure, PermissionModel>> getPagePermissions(String pageId);
  Future<Either<Failure, Map<String, dynamic>>> getById(
      String controllerName, String id);

  Future<Either<Failure, String>> add({
    required String controllerName,
    required Map<String, dynamic> body,
  });
  Future<Either<Failure, String>> edit({
    required String controllerName,
    required Map<String, dynamic> body,
  });

  Future<Either<Failure, DropdownModel>> getDropdownList({
    required String droModel,
    required String droValue,
    required String droText,
    required String droCondition,
    required String droCompany,
  });
}
