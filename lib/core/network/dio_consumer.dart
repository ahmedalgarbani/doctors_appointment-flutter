import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import '../services/get_it.dart';
import 'app_interceptors.dart';
import 'end_points.dart';

class DioConsumer {
  final Dio client;

  DioConsumer({required this.client}) {
    (client.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final httpClient = HttpClient();
      httpClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return httpClient;
    };

    client.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.json
      ..followRedirects = false
      ..connectTimeout = const Duration(seconds: 10)
      ..receiveTimeout = const Duration(seconds: 10)
      ..headers = {
        "Content-Type": "application/json",
      };

    client.interceptors.add(getIt.get<AppIntercepters>());

    if (kDebugMode) {
      client.interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
      ));
    }
  }
}
