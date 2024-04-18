import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
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
}
