import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/app_strings.dart';
import '../models/cost_balance_model.dart';
import 'cost_balance_repo.dart';

class CostBalanceRepoImpl implements CostBalanceRepo {
  final ApiService apiService;

  CostBalanceRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<CostBalanceModel>>> getCostBalance({
    required Map<String, dynamic> bodyRequest,
  }) async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      // var rrr = bodyRequest;
      List<dynamic> data = await apiService.post(
        endPoint: "web/AccountTrialBalance",
        data: bodyRequest,
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      List<CostBalanceModel> dataList = [];
      for (var i in data) {
        dataList.add(CostBalanceModel.fromJson(i));
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
}
