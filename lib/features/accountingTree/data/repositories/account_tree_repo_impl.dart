import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/utils/api_service.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/app_strings.dart';
import '../models/account_view_model.dart';
import '../models/add_edit_model.dart';
import 'account_tree_repo.dart';

class AccountTreeRepoImpl implements AccountTreeRepo {
  final ApiService apiService;

  AccountTreeRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<AccountTreeModel>>> getAllAccountTree() async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      List<dynamic> data = await apiService.get(
        endPoint: "web/AccountView/getAllData",
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      List<AccountTreeModel> dataList = [];
      for (var i in data) {
        dataList.add(AccountTreeModel.fromJson(i));
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
  Future<Either<Failure, String>> delete({required int id}) async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      await apiService.delete(
        endPoint: "web/AccountView?AcID=$id",
        data: jsonEncode(id),
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );

      return right("");
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
  Future<Either<Failure, AccountTreeModel>> add({required Map<String, dynamic> data}) async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      Map<String, dynamic> dataObj = await apiService.post(
        endPoint: "web/AccountView",
        data: data,
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      AddEditModel addEditModel = AddEditModel.fromJson(dataObj);
      return right(addEditModel.obj!);
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
  Future<Either<Failure, AccountTreeModel>> edit({required Map<String, dynamic> data}) async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      Map<String, dynamic> dataObj = await apiService.put(
        endPoint: "web/AccountView",
        data: data,
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      AddEditModel addEditModel = AddEditModel.fromJson(dataObj);
      return right(addEditModel.obj!);
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
