import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../models/table_data_model.dart';

abstract class CashMoneyRepo {
  Future<Either<Failure, double>> getMoney({required int accountId});

  Future<Either<Failure, String>> saveMoney({required Map<String, dynamic> bodyRequest});

  Future<Either<Failure, TableDataModel>> getTableData({
    required Map<String, dynamic> bodyRequest,
  });
}
