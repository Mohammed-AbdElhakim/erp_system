import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:erp_system/core/errors/failures.dart';
import 'package:erp_system/features/cashier/data/models/modality_model.dart';
import 'package:erp_system/features/cashier/data/models/pro_company_model.dart';
import 'package:erp_system/features/cashier/data/models/product_model.dart';

import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/app_strings.dart';
import 'cashier_repo.dart';

class CashierRepoImpl implements CashierRepo {
  final ApiService apiService;

  CashierRepoImpl(this.apiService);

  @override
  Future<Either<Failure, ModalityModel>> getModality() async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      // var rrr = jsonEncode(tapModel.toJson());
      Map<String, dynamic> data = await apiService.post(
        endPoint: "web/Structure/getDataGlobal",
        data: {"TableName": "modality"},
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      ModalityModel modalityModel = ModalityModel.fromJson(data);
      return right(modalityModel);
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioException(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ProCompanyModel>> getProCompany() async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      // var rrr = jsonEncode(tapModel.toJson());
      Map<String, dynamic> data = await apiService.post(
        endPoint: "web/Structure/getDataGlobal",
        data: {"TableName": "PRoCompany"},
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      ProCompanyModel proCompanyModel = ProCompanyModel.fromJson(data);
      return right(proCompanyModel);
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioException(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ProductModel>> getProduct() async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      // var rrr = jsonEncode(tapModel.toJson());
      Map<String, dynamic> data = await apiService.post(
        endPoint: "web/Structure/getDataGlobal",
        data: {"TableName": "Product"},
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      ProductModel productModel = ProductModel.fromJson(data);
      return right(productModel);
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioException(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }
}
