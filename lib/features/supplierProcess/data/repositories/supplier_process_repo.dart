import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/all_dropdown_model.dart';
import '../models/header_model.dart';

abstract class SupplierProcessRepo {
  Future<Either<Failure, List<HeaderModel>>> getHeaderTable({
    required String listName,
  });
  Future<Either<Failure, List<AllDropdownModel>>> getAllDropdownList({
    required int pageID,
  });

  Future<Either<Failure, String>> add({
    required String controllerName,
    required Map<String, dynamic> body,
  });

  Future<Either<Failure, Map<String, dynamic>>> getTableSupplierProcess(
      {required Map<String, dynamic> objectData, required String link});
}
