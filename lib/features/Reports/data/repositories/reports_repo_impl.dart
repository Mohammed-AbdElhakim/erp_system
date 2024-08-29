import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/app_strings.dart';
import '../models/report_model.dart';
import '../models/table_model.dart';
import 'reports_repo.dart';

class ReportsRepoImpl implements ReportsRepo {
  ApiService apiService;

  ReportsRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<ReportModel>>> getReports(
      {required int pageId}) async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      List<dynamic> data = await apiService.get(
        endPoint: "web/PivotStructure/getPivot/$pageId",
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      List<ReportModel> reports = [];
      for (var element in data) {
        reports.add(ReportModel.fromJson(element));
      }

      return right(reports);
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
  Future<Either<Failure, TableModel>> getTableReports(
      {required int reportId}) async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      Map<String, dynamic> data = await apiService
          .post(endPoint: "web/PivotStructure/getDataGlobal", headers: {
        "Authorization": "Bearer $token",
        "CompanyKey": companyKey,
      }, data: {
        "Id": reportId
      });

      TableModel tableModel = TableModel.fromJson(data);

      return right(tableModel);
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
