import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String errorMassage;

  const Failure(this.errorMassage);
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure(super.errorMassage);

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure("connection Timeout with api server");
      case DioExceptionType.sendTimeout:
        return const ServerFailure("send Timeout with api server");
      case DioExceptionType.receiveTimeout:
        return const ServerFailure("receive Timeout with api server");
      case DioExceptionType.badCertificate:
        return const ServerFailure("bad Certificate with api server");
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioException.response!.statusCode!, dioException.response!.data);
      case DioExceptionType.cancel:
        return const ServerFailure("Request to api server was canceled");
      case DioExceptionType.connectionError:
        return const ServerFailure(
            "Request to api server was Connection Error");
      case DioExceptionType.unknown:
        if (dioException.message!.contains("SocketException")) {
          return const ServerFailure("No Internet Connection");
        }
        return const ServerFailure("Unexpected Error, Please try again!");
      default:
        return const ServerFailure(
            "Opps There was an error, Please try again!");
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response);
    } else if (statusCode == 404) {
      return const ServerFailure("Your request not found, Please try later!");
    } else if (statusCode == 500) {
      return const ServerFailure("Internal Server error, Please try later!");
    } else {
      return const ServerFailure("Opps There was an error, Please try again!");
    }
  }
}
