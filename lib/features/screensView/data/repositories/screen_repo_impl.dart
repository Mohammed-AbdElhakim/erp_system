import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:erp_system/core/errors/failures.dart';
import 'package:erp_system/core/models/menu_model/menu_model.dart';
import 'package:erp_system/core/models/menu_model/pages.dart';
import 'package:erp_system/features/screensView/data/repositories/screen_repo.dart';

import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/app_strings.dart';

class ScreenRepoImpl implements ScreenRepo {
  final ApiService apiService;

  ScreenRepoImpl(this.apiService);
  @override
  Future<Either<Failure, MenuModel>> getScreen(Pages page) async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      Map<String, dynamic> data = await apiService.get(
        endPoint: "home/getmenu",
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
