import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../core/models/menu_model/pages.dart';
import '../models/column_data_model.dart';

abstract class ScreenRepo {
  Future<Either<Failure, ScreenModel>> getScreen(Pages page);
}
