import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctors_appointment/core/error/failure.dart';
import 'package:doctors_appointment/core/network/end_points.dart';
import '../../../core/services/api_service.dart';
import '../../../core/services/get_it.dart';
import 'profile_model.dart';

class ProfileMethod {
  static final dio = getIt<ApiService>();

  static Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await dio.post(
        EndPoints.change_password,
        data: {
          'old_password': oldPassword,
          'new_password': newPassword,
        },
      );

      if (response.statusCode != 200) {
        log('Password change failed with status: ${response.statusCode}');
        throw Exception('فشل في تغيير كلمة المرور');
      }

      log('Password changed successfully');
    } on DioException catch (e) {
      log('DioException in changePassword: ${e.response?.data}');
      throw ServerFailure.fromResponseError(e);
    } catch (e) {
      log('Unexpected error in changePassword: $e');
      throw Exception('حدث خطأ غير متوقع');
    }
  }

  static Future<UserProfile> getProfile() async {
    try {
      final response = await dio.get(
        EndPoints.profile,
      );
      log('Fetched profile: ${response.data}');
      return UserProfile.fromJson(response.data);
    } on DioException catch (e) {
      log('DioException in getProfile: ${e.response?.data}');
      throw ServerFailure.fromResponseError(e);
    } catch (e) {
      log('Unexpected error in getProfile: $e');
      throw Exception('فشل في تحميل الملف الشخصي');
    }
  }

  static Future<void> updateProfile(UserProfile profile) async {
    try {
      final response = await dio.put(
        EndPoints.profile,
        profile.toJson(),
      );

      if (response.statusCode != 200) {
        log('Update failed with status: ${response.statusCode}');
        throw Exception('فشل في تحديث الملف الشخصي');
      }

      log('Profile updated successfully');
    } on DioException catch (e) {
      log('DioException in updateProfile: ${e.response?.data}');
      throw ServerFailure.fromResponseError(e);
    } catch (e) {
      log('Unexpected error in updateProfile: $e');
      throw Exception('حدث خطأ أثناء تحديث البيانات');
    }
  }
}
