import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:erp_system/core/errors/failures.dart';
import 'package:erp_system/features/auth/data/repositories/login/login_repo.dart';

import '../../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../../core/utils/api_service.dart';
import '../../../../../core/utils/app_strings.dart';

class LoginRepoImpl implements LoginRepo {
  final ApiService apiService;

  LoginRepoImpl(this.apiService);

  @override
  Future<Either<Failure, String>> loginUser(
      {required String username, required String password}) async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      var data = await apiService.post(endPoint: "Auth/Login", data: {
        "UserName": username,
        "Password": password,
      }, headers: {
        // "Cache-Control": "no-cache",
        // "Postman-Token": "<calculated when request is sent>",
        // "Content-Type": "application/json",
        // "Content-Length": "<calculated when request is sent>",
        // "Host": "<calculated when request is sent>",
        // "User-Agent": "PostmanRuntime/7.36.3",
        // "Accept": "*/*",
        // "Accept-Encoding": "gzip, deflate, br",
        // "Connection": "keep-alive",
        "CompanyKey": companyKey,
      });
      String token = json.encode(data);
      return right(token);
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
