import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../../core/utils/api_service.dart';
import '../../../../../core/utils/app_strings.dart';
import 'general_repo.dart';

class GeneralRepoImpl implements GeneralRepo {
  final ApiService apiService;

  GeneralRepoImpl(this.apiService);

  @override
  Future<Either<Failure, Map<String, dynamic>>> getDataGlobal(
      {required String link, required Map<String, dynamic> bodyRequest}) async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      Map<String, dynamic> data = await apiService.post(
        endPoint: "web/$link/getDataGlobal",
        data: bodyRequest,
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
  Future<Either<Failure, List<dynamic>>> getListSetup({
    required String link,
    required String listName,
  }) async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      List<dynamic> data = await apiService.get(
        endPoint: "web/$link/getListSetups/$listName",
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
