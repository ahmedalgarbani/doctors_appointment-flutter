import 'package:dio/dio.dart';
import 'package:doctors_appointment/core/error/failure.dart';
import 'package:doctors_appointment/core/network/dio_consumer.dart';
import 'package:doctors_appointment/core/services/get_it.dart';
import '../network/api_consumer.dart';

class ApiService extends ApiConsumer {
  final Dio _dio = DioConsumer(client: getIt.get<Dio>()).client;

  Future<Response> get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      Response response = await _dio.get(endpoint, queryParameters: params);
      return response;
    } catch (e) {
      throw Exception("GET request failed: $e");
    }
  }
Future<Response> post(
  String endpoint, {
  Map<String, dynamic>? data,
  Options? options,
}) async {
  try {
    final response = await _dio.post(endpoint, data: data, options: options);
    return response;
  } on DioException catch (e) {
    throw ServerFailure.fromDiorError(e);
  } catch (ex) {
    throw Exception(ex.toString());
  }
}
Future<Response> postFormData(
  String endpoint, {
  required FormData data,
  Options? options,
}) async {
  try {
    final response = await _dio.post(endpoint, data: data, options: options);
    return response;
  } on DioException catch (e) {
    throw ServerFailure.fromDiorError(e);
  } catch (ex) {
    throw Exception(ex.toString());
  }
}

  Future<Response> put(String endpoint, dynamic data) async {
    try {
      Response response = await _dio.put(endpoint, data: data);
      return response;
    } catch (e) {
      throw Exception("PUT request failed: $e");
    }
  }

  Future<Response> delete(String endpoint,
      {Map<String, dynamic>? data}) async {
    try {
      Response response = await _dio.delete(endpoint, data: data);
      return response;
    } catch (e) {
      throw Exception("DELETE request failed: $e");
    }
  }
}
