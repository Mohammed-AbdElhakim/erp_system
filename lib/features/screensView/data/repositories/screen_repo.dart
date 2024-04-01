import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/models/menu_model/menu_model.dart';
import '../../../../core/models/menu_model/pages.dart';

abstract class ScreenRepo {
  Future<Either<Failure, MenuModel>> getScreen(Pages page);
}
