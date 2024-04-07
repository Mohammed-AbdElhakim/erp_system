import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:erp_system/core/errors/failures.dart';
import 'package:erp_system/core/utils/api_service.dart';

import '../../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../../core/models/menu_model/menu_model.dart';
import '../../../../../core/utils/app_strings.dart';
import 'menu_repo.dart';

class MenuRepoImpl implements MenuRepo {
  final ApiService apiService;

  MenuRepoImpl(this.apiService);

  @override
  Future<Either<Failure, MenuModel>> getMenu() async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      Map<String, dynamic> data = await apiService.get(
        endPoint: "Home/GetMenu",
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      MenuModel menuModel = MenuModel.fromJson(data);

      return right(menuModel);
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
