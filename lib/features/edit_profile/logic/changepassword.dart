import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctors_appointment/core/error/failure.dart';

import '../../../core/services/api_service.dart';
import '../../../core/services/get_it.dart';

class ProfileMethod {
  static Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final _dio = getIt.get<ApiService>();

    try {
      final response = await _dio.post(
        'change-password/',
        data: {
          'old_password': oldPassword,
          'new_password': newPassword,
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to change password');
      }
    
    } on DioException catch (e) {
      throw ServerFailure.fromResponseError(e);
    } catch (e) {
      throw e;
    }
  }
}
