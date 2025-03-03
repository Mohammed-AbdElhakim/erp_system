import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:erp_system/core/errors/failures.dart';

import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/app_strings.dart';
import '../models/all_dropdown_model.dart';
import '../models/header_model.dart';
import '../models/screen_model.dart';
import 'supplier_process_repo.dart';

class SupplierProcessRepoImpl implements SupplierProcessRepo {
  final ApiService apiService;

  SupplierProcessRepoImpl(this.apiService);

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
  Future<Either<Failure, List<HeaderModel>>> getHeaderTable({
    required String listName,
  }) async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      List<dynamic> data = await apiService.get(
        endPoint: "web/Structure/getListSetups/$listName",
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );

      List<HeaderModel> headerList = [];
      for (var i in data) {
        headerList.add(HeaderModel.fromJson(i));
      }

      return right(headerList);
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
  Future<Either<Failure, ScreenModel>> getTable({
    required int pageId,
    required bool employee,
    required bool isdesc,
    required int limit,
    required int offset,
    required String orderby,
    required String statment,
    required String selectcolumns,
    required bool isDepartment,
    required String departmentName,
    required int authorizationID,
    required String viewEmployeeColumn,
  }) async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      Map<String, dynamic> data = await apiService.post(
        endPoint: "home/getGeneralTable",
        data: {
          "pageId": pageId,
          "employee": employee,
          "isdesc": isdesc,
          "limit": limit,
          "offset": offset,
          "orderby": orderby,
          "statment": statment,
          "selectcolumns": selectcolumns,
          "IsDepartment": isDepartment,
          "DepartmentName": departmentName,
          "AuthorizationID": authorizationID,
          "ViewEmployeeColumn": viewEmployeeColumn
        },
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      ScreenModel screenModel = ScreenModel.fromJson(data);

      return right(screenModel);
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

  @override
  Future<Either<Failure, Map<String, dynamic>>> getTableSupplierProcess(
      {required Map<String, dynamic> objectData, required String link}) async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      // var rrr = jsonEncode(objectData);
      Map<String, dynamic> data = await apiService.post(
        endPoint: "web/$link/getDataGlobal",
        data: objectData,
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );

      return right(data);
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
