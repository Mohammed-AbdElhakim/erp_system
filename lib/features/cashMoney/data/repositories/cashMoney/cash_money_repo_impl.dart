import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../../core/utils/api_service.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../models/table_data_model.dart';
import 'cash_money_repo.dart';

class CashMoneyRepoImpl implements CashMoneyRepo {
  final ApiService apiService;

  CashMoneyRepoImpl(this.apiService);

  @override
  Future<Either<Failure, double>> getMoney({required int accountId}) async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      double data = await apiService.get(
        endPoint: "web/SafeAccount/$accountId",
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

  @override
  Future<Either<Failure, String>> saveMoney({required Map<String, dynamic> bodyRequest}) async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";

      await apiService.post(
        endPoint: "web/SafeAccount",
        data: bodyRequest,
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
  Future<Either<Failure, TableDataModel>> getTableData({required Map<String, dynamic> bodyRequest}) async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";

      Map<String, dynamic> data = await apiService.post(
        endPoint: "web/ProfAccount/getDataGlobal",
        data: bodyRequest,
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      TableDataModel tableDataModel = TableDataModel.fromJson(data);
      return right(tableDataModel);
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
