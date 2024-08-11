import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/app_strings.dart';
import '../models/general_balance_body_model.dart';
import '../models/general_balance_model.dart';
import 'general_balance_repo.dart';

class GeneralBalanceRepoImpl implements GeneralBalanceRepo {
  final ApiService apiService;

  GeneralBalanceRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<GeneralBalanceModel>>> getGeneralBalance({
    required GeneralBalanceBodyModel generalBalanceBodyModel,
  }) async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      // var rrr = jsonEncode(trialBalanceBody.toJson());
      List<dynamic> data = await apiService.post(
        endPoint: "web/genralBalance",
        data: generalBalanceBodyModel.toJson(),
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      List<GeneralBalanceModel> dataList = [];
      for (var i in data) {
        dataList.add(GeneralBalanceModel.fromJson(i));
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
