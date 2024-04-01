import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/models/menu_model/menu_model.dart';

abstract class MenuRepo {
  Future<Either<Failure, MenuModel>> getMenu();
}
