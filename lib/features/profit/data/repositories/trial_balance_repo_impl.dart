import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/app_strings.dart';
import '../models/profit_body_model.dart';
import '../models/profit_model.dart';
import 'profit_repo.dart';

class ProfitRepoImpl implements ProfitRepo {
  final ApiService apiService;

  ProfitRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<ProfitModel>>> getProfit({
    required ProfitBodyModel profitBodyModel,
  }) async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      // var rrr = jsonEncode(trialBalanceBody.toJson());
      List<dynamic> data = await apiService.post(
        endPoint: "web/profit",
        data: profitBodyModel.toJson(),
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      List<ProfitModel> dataList = [];
      for (var i in data) {
        dataList.add(ProfitModel.fromJson(i));
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
