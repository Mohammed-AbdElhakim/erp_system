import 'package:dartz/dartz.dart';

import '../../errors/failures.dart';

abstract class GeneralRepo {
  Future<Either<Failure, Map<String, dynamic>>> getDataGlobal({required Map<String, dynamic> bodyRequest});
}
