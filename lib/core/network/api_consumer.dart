import 'package:dio/dio.dart';

abstract class ApiConsumer {
  Future<Response> get(String endpoint, {Map<String, dynamic>? params});

  Future<Response> post(String endpoint,
      {Map<String, dynamic>? data, Options? options});

  Future<Response> delete(String endpoint, {Map<String, dynamic>? data});

  Future<Response> put(String endpoint, dynamic data);
  Future<Response> postFormData(
    String endpoint, {
    required FormData data,
    Options? options,
  });
}
