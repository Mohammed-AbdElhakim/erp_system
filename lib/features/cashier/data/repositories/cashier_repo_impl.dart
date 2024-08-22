import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:erp_system/core/errors/failures.dart';
import 'package:erp_system/features/cashier/data/models/all_dropdown_model.dart';
import 'package:erp_system/features/cashier/data/models/item_list_setup_model.dart';
import 'package:erp_system/features/cashier/data/models/modality_model.dart';
import 'package:erp_system/features/cashier/data/models/pro_company_model.dart';
import 'package:erp_system/features/cashier/data/models/product_model.dart';
import 'package:erp_system/features/cashier/data/models/tap_model.dart';

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

  @override
  Future<Either<Failure, List<AllDropdownModel>>> getAllDropdownList(
      {required int pageID}) async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      List<dynamic> data = await apiService.get(
        endPoint: "home/GetPageDropDown?pageId=$pageID",
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );

      List<AllDropdownModel> dataList = [];
      for (var i in data) {
        dataList.add(AllDropdownModel.fromJson(i));
      }

      return right(dataList);
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
  Future<Either<Failure, TapModel>> getPageDetails(
      {required int pageID}) async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      Map<String, dynamic> data = await apiService.get(
        endPoint: "home/GetPageDetails?pageid=$pageID",
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      TapModel tapModel = TapModel.fromJson(data);

      return right(tapModel);
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
  Future<Either<Failure, List<ItemListSetupModel>>> getListSetups({
    required String pageListName,
  }) async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      List<dynamic> data = await apiService.get(
        endPoint: "web/Structure/getListSetups/$pageListName",
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      List<ItemListSetupModel> dataList = [];
      for (var i in data) {
        dataList.add(ItemListSetupModel.fromJson(i));
      }

      return right(dataList);
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
  Future<Either<Failure, String>> addProduct(
      {required Map<String, dynamic> body,
      required String controllerName}) async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";

      var data = await apiService.post(
        endPoint: "web/$controllerName",
        data: body,
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      return right(data.toString());
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
  Future<Either<Failure, String>> add({
    required String controllerName,
    required Map<String, dynamic> body,
  }) async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";

      var data = await apiService.post(
        endPoint: "home/AddEdit?controllerName=$controllerName",
        data: body,
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      return right(data.toString());
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
