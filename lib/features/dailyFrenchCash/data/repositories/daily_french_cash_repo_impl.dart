import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/app_strings.dart';
import '../models/accounts_model.dart';
import '../models/body_request_daily_french_cash.dart';
import '../models/daily_french_cash_model.dart';
import 'daily_french_cash_repo.dart';

class DailyFrenchCashRepoImpl implements DailyFrenchCashRepo {
  final ApiService apiService;

  DailyFrenchCashRepoImpl(this.apiService);
  @override
  Future<Either<Failure, DailyFrenchCashModel>> getDailyFrenchCash(
      {required BodyRequestDailyFrenchCash bodyRequestDailyFrenchCash}) async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      // var rrr = jsonEncode(bodyRequestDailyFrenchCash.toJson());
      Map<String, dynamic> data = await apiService.post(
        endPoint: "web/DailyFrenshCash/PostFrensh",
        data: bodyRequestDailyFrenchCash.toJson(),
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      DailyFrenchCashModel dailyFrenchCashModel = DailyFrenchCashModel.fromJson(data);

      return right(dailyFrenchCashModel);
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
  Future<Either<Failure, AccountsModel>> getAccountsList() async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      Map<String, dynamic> data = await apiService.post(
        endPoint: "web/Structure/getDataGlobal",
        data: {"tableName": "MonyAccount"},
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      AccountsModel accountsModel = AccountsModel.fromJson(data);

      return right(accountsModel);
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
