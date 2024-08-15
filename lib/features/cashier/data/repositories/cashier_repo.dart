import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/modality_model.dart';
import '../models/pro_company_model.dart';
import '../models/product_model.dart';

abstract class CashierRepo {
  Future<Either<Failure, ProCompanyModel>> getProCompany();
  Future<Either<Failure, ModalityModel>> getModality();
  Future<Either<Failure, ProductModel>> getProduct();
}
