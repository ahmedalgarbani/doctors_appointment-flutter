import 'package:dio/dio.dart';

abstract class ApiConsumer {
  Future<Response> get(String endpoint, {Map<String, dynamic>? params});

  Future<Response> post(String endpoint, dynamic data,{Options? options});

  Future<Response> delete(String endpoint, {Map<String, dynamic>? params});

  Future<Response> put(String endpoint, dynamic data);
}
