import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../core/models/menu_model/pages.dart';
import '../models/column_data_model.dart';
import '../models/permission_model.dart';

abstract class ScreenRepo {
  Future<Either<Failure, ScreenModel>> getTable(Pages page);
  Future<Either<Failure, PermissionModel>> getPagePermissions(String pageId);
}
