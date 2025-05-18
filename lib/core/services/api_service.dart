import 'package:dio/dio.dart';
import 'package:doctors_appointment/core/error/failure.dart';
import 'package:doctors_appointment/core/network/dio_consumer.dart';
import 'package:doctors_appointment/core/services/get_it.dart';
import 'package:flutter/widgets.dart';
import '../network/api_consumer.dart';
import 'dart:developer';

class ApiService extends ApiConsumer {
  final Dio _dio = DioConsumer(client: getIt.get<Dio>()).client;

@override
Future<Response> get(String endpoint, {Map<String, dynamic>? params}) async {
  try {
    debugPrint('Making request to: $endpoint'); // Add this
    final Response response = await _dio.get(endpoint, queryParameters: params);
    debugPrint('Response: ${response.statusCode} ${response.data}'); // Add this
    return response;
  } on DioException catch (e) {
    debugPrint('DioError: ${e.message}'); // Add this
    throw ServerFailure.fromDiorError(e);
  } catch (ex) {
    debugPrint('Error: $ex'); // Add this
    throw ServerFailure(errorMessage: ex.toString());
  }
}

  @override
  Future<Response> post(String endpoint, 
      {Map<String, dynamic>? data, Options? options}) async {
    try {
      final response = await _dio.post(endpoint, data: data, options: options);
      return response;
    } on DioException catch (e) {
      throw ServerFailure.fromDiorError(e);
    }
  }

  @override
  Future<Response> put(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      throw ServerFailure.fromDiorError(e);
    }
  }

  @override
  Future<Response> delete(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.delete(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      log(e.toString());
      throw e;
    } catch (ex) {
      log(ex.toString());
      throw Exception(ex.toString());
    }
  }

  @override
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
    }
  }
  
}