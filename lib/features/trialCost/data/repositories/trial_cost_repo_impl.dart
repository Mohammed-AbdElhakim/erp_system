import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/app_strings.dart';
import '../models/trial_cost_body_model.dart';
import '../models/trial_cost_model.dart';
import 'trial_cost_repo.dart';

class TrialCostRepoImpl implements TrialCostRepo {
  final ApiService apiService;

  TrialCostRepoImpl(this.apiService);

  @override
  Future<Either<Failure, TrialCostModel>> getTrialCost({
    required TrialCostBodyModel trialCostBody,
  }) async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      // var rrr = jsonEncode(trialCostBody.toJson());
      Map<String, dynamic> data = await apiService.post(
        endPoint: "web/TrialAccount",
        data: trialCostBody.toJson(),
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      TrialCostModel dataTrialCost = TrialCostModel.fromJson(data);

      return right(dataTrialCost);
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
