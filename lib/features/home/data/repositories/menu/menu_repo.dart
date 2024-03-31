import 'package:dartz/dartz.dart';
import 'package:erp_system/features/home/data/models/menu_model/menu_model.dart';

import '../../../../../core/errors/failures.dart';

abstract class MenuRepo {
  Future<Either<Failure, MenuModel>> getMenu();
}
