import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../core/models/menu_model/pages.dart';
import '../models/column_data_model.dart';

abstract class TableRepo {
  Future<Either<Failure, ScreenModel>> getTable(Pages page);
}
