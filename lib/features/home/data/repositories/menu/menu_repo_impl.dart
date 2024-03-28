import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:erp_system/core/errors/failures.dart';
import 'package:erp_system/features/home/data/models/menu_model.dart';

import '../../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../../core/utils/api_service.dart';
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
      Map<String, dynamic> data =
          await apiService.get(endPoint: "home/getmenu", headers: {
        "Authorization": "Bearer $token",
        // "Cache-Control": "no-cache",
        // "Postman-Token": "<calculated when request is sent>",
        // "Host": "http://161.97.161.180:660/api",
        // "User-Agent": "PostmanRuntime/7.36.3",
        // "Accept": "*/*",
        // "Accept-Encoding": "gzip, deflate, br",
        // "Connection": "keep-alive",
        "CompanyKey": companyKey,
      });
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
