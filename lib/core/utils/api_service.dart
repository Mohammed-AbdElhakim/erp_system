import 'package:dio/dio.dart';

class ApiService {
  final String _baseUrl = '';
  final Dio _dio;

  ApiService(this._dio);
  Future<Map<String, dynamic>> get({required String endPoint}) async {
    Response response = await _dio.get("$_baseUrl$endPoint");
    return response.data;
  }
}
