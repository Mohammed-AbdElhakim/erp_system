import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/app_strings.dart';
import '../models/location_model.dart';
import '../models/valid_device_model.dart';
import 'attendance_repo.dart';

class AttendanceRepoImpl implements AttendanceRepo {
  final ApiService apiService;

  AttendanceRepoImpl(this.apiService);
  @override
  Future<Either<Failure, ValidDeviceModel>> checkValidDevice() async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String deviceKey =
          await Pref.getStringFromPref(key: AppStrings.uniqueIdKey) ?? "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";

      Map<String, dynamic> data = await apiService.post(
        endPoint: "Attendance/CheckValidDevice",
        data: jsonEncode(deviceKey),
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      // Map<String, dynamic> data = {"status": "Valid"};
      ValidDeviceModel validDeviceModel = ValidDeviceModel.fromJson(data);
      return right(validDeviceModel);
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
  Future<Either<Failure, LocationModel>> getAttendanceLocations() async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";

      Map<String, dynamic> data = await apiService.get(
        endPoint: "Attendance/GetAttendanceLocations",
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      LocationModel locationModel = LocationModel.fromJson(data);
      return right(locationModel);
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
  Future<Either<Failure, String>> sendAttendance({
    required String machineID,
    required String time,
    required String checkType,
    required String deviceName,
    required double long,
    required double lat,
  }) async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";

      String data = await apiService.post(
        endPoint: "Attendance/SendAttendance",
        data: {
          "MachineID": machineID,
          "CheckDateTime": time,
          "CheckType": checkType, //"CheckIn" or "CheckOut"
          "Longitude": long,
          "Latitude": lat,
          "DeviceName": deviceName,
        },
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
