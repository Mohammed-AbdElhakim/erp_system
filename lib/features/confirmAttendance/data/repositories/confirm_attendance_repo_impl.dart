import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:erp_system/core/errors/failures.dart';
import 'package:erp_system/core/utils/api_service.dart';

import 'package:erp_system/features/confirmAttendance/data/models/confirm_attendance_model.dart';

import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/app_strings.dart';
import 'confirm_attendance_repo.dart';

class ConfirmAttendanceRepoImpl extends ConfirmAttendanceRepo {
  final ApiService apiService;

  ConfirmAttendanceRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<ConfirmAttendanceModel>>> getDataConfirmAttendanceList({
    required Map<String, dynamic> bodyRequest,
  }) async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      List<dynamic> data = await apiService.post(
        endPoint: "web/ConfirmAttendance",
        data: bodyRequest,
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      List<ConfirmAttendanceModel> listData = [];
      for (var item in data) {
        listData.add(ConfirmAttendanceModel.fromJson(item));
      }

      return right(listData);
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
  Future<Either<Failure, String>> confirmAttendance({
    required List<Map<String, dynamic>> bodyRequest,
  }) async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      await apiService.post(
        endPoint: "web/ConfirmAttendance/confirm",
        data: bodyRequest,
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );

      return right("");
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
