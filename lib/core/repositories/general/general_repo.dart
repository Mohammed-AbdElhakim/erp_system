import 'package:dartz/dartz.dart';

import '../../errors/failures.dart';

abstract class GeneralRepo {
  Future<Either<Failure, Map<String, dynamic>>> getDataGlobal({
    required String link,
    required Map<String, dynamic> bodyRequest,
  });

  Future<Either<Failure, List<dynamic>>> getListSetup({
    required String link,
    required String listName,
  });
}
