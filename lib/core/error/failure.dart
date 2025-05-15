import 'dart:developer';

import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  Failure(this.errorMessage);
}

class SqlFailure extends Failure {
  SqlFailure({required String errorMessage}) : super(errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure({required String errorMessage}) : super(errorMessage);

  factory ServerFailure.fromDiorError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
            errorMessage: 'Connection timeout with api server');
      case DioExceptionType.sendTimeout:
        return ServerFailure(errorMessage: 'Send timeout with ApiServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errorMessage: 'Receive timeout with ApiServer');
      case DioExceptionType.badCertificate:
        return ServerFailure(errorMessage: 'badCertificate with api server');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            e.response!.statusCode!, e.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure(errorMessage: 'Request to ApiServer was canceld');
      case DioExceptionType.connectionError:
        return ServerFailure(errorMessage: 'No Internet Connection');
      case DioExceptionType.unknown:
        return ServerFailure(
            errorMessage: 'Opps There was an Error, Please try again');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 404) {
      return ServerFailure(
          errorMessage: 'Your request was not found, please try later');
    } else if (statusCode == 500) {
      return ServerFailure(
          errorMessage: 'There is a problem with server, please try later');
    } else if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      if (response != null) {
        //!TODO
        return ServerFailure(errorMessage: "Invalid credentials");
      } else if (response != null && response['error'] != null) {
        return ServerFailure(errorMessage: response['error'][0]);
      } else if (response != null &&
          response['error'] != null &&
          response['error']['password2'] != null) {
        return ServerFailure(errorMessage: response['error']['password2'][0]);
      } else if (response != null &&
          response['error'] != null &&
          response['error']['username'] != null) {
        return ServerFailure(errorMessage: response['error']['username'][0]);
      } else if (response != null && response['message'] != null) {
        return ServerFailure(errorMessage: response['message']);
      } else {
        return ServerFailure(errorMessage: 'Unknown error occurred');
      }
    } else {
      return ServerFailure(
          errorMessage: 'There was an error, please try again');
    }
  }

  factory ServerFailure.fromResponseError(DioException error) {
    try {
      if (error.response?.data is Map<String, dynamic>) {
        final data = error.response!.data;

        if (data.containsKey('detail')) {
          return ServerFailure(errorMessage: data['detail']);
        }

        if (data.containsKey('old_password')) {
          return ServerFailure(errorMessage: data['old_password'][0]);
        }

        if (data.isNotEmpty) {
          final errors = data.entries.map((entry) {
            final value = entry.value;
            if (value is List && value.isNotEmpty) {
              return "${entry.key}: ${value.first}";
            } else {
              return "${entry.key}: $value";
            }
          }).join("\n");

          return ServerFailure(errorMessage: errors);
        }
      }

      return ServerFailure(
          errorMessage: "حدث خطأ غير متوقع. الرجاء المحاولة لاحقاً.");
    } catch (e) {
      log(e.toString());
      log(e.toString());
      log(e.toString());
      log(e.toString());
      log(e.toString());
      return ServerFailure(
          errorMessage: "فشل في الاتصال بالخادم."); // this print
    }
  }

  @override
  String toString() => errorMessage;
}
