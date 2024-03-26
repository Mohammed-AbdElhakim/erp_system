import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:erp_system/core/errors/failures.dart';
import 'package:erp_system/features/auth/data/repositories/login/login_repo.dart';

import '../../../../../core/utils/api_service.dart';

class LoginRepoImpl implements LoginRepo {
  final ApiService apiService;

  LoginRepoImpl(this.apiService);

  @override
  Future<Either<Failure, String>> loginUser(
      {required String username, required String password}) async {
    try {
      Map<String, dynamic> data =
          await apiService.post(endPoint: "Auth/Login", data: {
        "UserName": username,
        "Password": password,
      }, headers: {});
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
