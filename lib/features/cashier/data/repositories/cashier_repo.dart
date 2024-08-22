import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/all_dropdown_model.dart';
import '../models/item_list_setup_model.dart';
import '../models/modality_model.dart';
import '../models/pro_company_model.dart';
import '../models/product_model.dart';
import '../models/tap_model.dart';

abstract class CashierRepo {
  Future<Either<Failure, ProCompanyModel>> getProCompany();
  Future<Either<Failure, ModalityModel>> getModality();
  Future<Either<Failure, ProductModel>> getProduct();

  Future<Either<Failure, List<AllDropdownModel>>> getAllDropdownList({
    required int pageID,
  });

  Future<Either<Failure, TapModel>> getPageDetails({
    required int pageID,
  });

  Future<Either<Failure, List<ItemListSetupModel>>> getListSetups({
    required String pageListName,
  });

  Future<Either<Failure, String>> addProduct(
      {required Map<String, dynamic> body, required String controllerName});

  Future<Either<Failure, String>> add({
    required String controllerName,
    required Map<String, dynamic> body,
  });
}
