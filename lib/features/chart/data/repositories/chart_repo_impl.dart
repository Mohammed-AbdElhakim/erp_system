import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:erp_system/core/errors/failures.dart';
import 'package:erp_system/features/chart/data/models/chart_page_model.dart';

import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/app_strings.dart';
import '../models/chart_master_model.dart';
import '../models/chart_model.dart';
import 'chart_repo.dart';

class ChartRepoImpl implements ChartRepo {
  final ApiService apiService;

  ChartRepoImpl(this.apiService);
  @override
  Future<Either<Failure, ChartModel>> getChartData(
      {required String tableOrView}) async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      // var rrr = jsonEncode(tapModel.toJson());
      Map<String, dynamic> data = await apiService.post(
        endPoint: "web/Structure/getDataGlobal",
        data: {"TableName": tableOrView},
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      ChartModel chartModel = ChartModel.fromJson(data);
      return right(chartModel);
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
  Future<Either<Failure, ChartMasterModel>> getChartMaster() async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      // var rrr = jsonEncode(tapModel.toJson());
      Map<String, dynamic> data = await apiService.post(
        endPoint: "web/Structure/getDataGlobal",
        data: {"TableName": "ChartMaster"},
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      ChartMasterModel chartMasterModel = ChartMasterModel.fromJson(data);
      return right(chartMasterModel);
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
  Future<Either<Failure, ChartPageModel>> getChartPage() async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      // var rrr = jsonEncode(tapModel.toJson());
      Map<String, dynamic> data = await apiService.post(
        endPoint: "web/Structure/getDataGlobal",
        data: {"TableName": "ChartPages"},
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      ChartPageModel chartPageModel = ChartPageModel.fromJson(data);
      return right(chartPageModel);
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
