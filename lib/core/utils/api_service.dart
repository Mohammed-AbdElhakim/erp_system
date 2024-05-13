import 'package:dio/dio.dart';

import '../helper/SharedPreferences/pref.dart';
import 'app_strings.dart';

class ApiService {
  final String _baseUrl = '/api/';
  final Dio _dio;

  ApiService(this._dio);
  Future<dynamic> get({
    required String endPoint,
    required Map<String, dynamic>? headers,
  }) async {
    String host = await Pref.getStringFromPref(key: AppStrings.hostKey) ?? "";
    Response response = await _dio.get(
      "$host$_baseUrl$endPoint",
      options: Options(
        headers: headers,
      ),
    );
    return response.data;
  }

  Future<dynamic> post({
    required String endPoint,
    required Object? data,
    required Map<String, dynamic>? headers,
  }) async {
    String host = await Pref.getStringFromPref(key: AppStrings.hostKey) ?? "";
    Response response = await _dio.post(
      "$host$_baseUrl$endPoint",
      data: data,
      options: Options(
        headers: headers,
      ),
    );
    return response.data;
  }

  Future<dynamic> put({
    required String endPoint,
    required Object? data,
    required Map<String, dynamic>? headers,
  }) async {
    String host = await Pref.getStringFromPref(key: AppStrings.hostKey) ?? "";
    Response response = await _dio.put(
      "$host$_baseUrl$endPoint",
      data: data,
      options: Options(
        headers: headers,
      ),
    );
    return response.data;
  }

  Future<dynamic> delete({
    required String endPoint,
    required Map<String, dynamic>? headers,
  }) async {
    String host = await Pref.getStringFromPref(key: AppStrings.hostKey) ?? "";
    Response response = await _dio.delete(
      "$host$_baseUrl$endPoint",
      options: Options(
        headers: headers,
      ),
    );
    return response.data;
  }
}
