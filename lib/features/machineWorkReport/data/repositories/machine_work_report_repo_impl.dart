import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/app_strings.dart';
import '../models/machine_work_report_model.dart';
import 'machine_work_report_repo.dart';

class MachineWorkReportRepoImpl implements MachineWorkReportRepo {
  final ApiService apiService;

  MachineWorkReportRepoImpl(this.apiService);

  @override
  Future<Either<Failure, MachineWorkReportModel>> getMachineWorkReport({
    required Map<String, dynamic> bodyRequest,
  }) async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      // var rrr = bodyRequest;
      Map<String, dynamic> data = await apiService.post(
        endPoint: "web/Structure/getDataGlobal",
        data: bodyRequest,
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      MachineWorkReportModel dataResult = MachineWorkReportModel.fromJson(data);

      return right(dataResult);
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
