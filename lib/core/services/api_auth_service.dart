import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:doctors_appointment/core/error/failure.dart';
import 'package:doctors_appointment/core/helpers/get_platform.dart';
import 'package:doctors_appointment/core/network/end_points.dart';
import 'package:doctors_appointment/core/network/status_code.dart';
import 'package:doctors_appointment/core/services/api_service.dart';
import 'package:doctors_appointment/features/auth/data/model/create_user_request.dart';
import 'package:doctors_appointment/features/auth/data/model/signin_user_request.dart';
import 'package:doctors_appointment/features/auth/data/sources/auth_service.dart';

import '../constant/constant.dart';
import '../helpers/shared_prefrace.dart';
import 'get_it.dart';

class ApiAuthService extends AuthService {
  @override
  Future<void> createUserWithEmailAndPassword(
      {required Patient patient}) async {
    try {
      FormData formData = await patient.toFormData();

      final response = await getIt.get<ApiService>().post(
            EndPoints.register,
            formData,
            options: Options(
              headers: {
                "Content-Type":
                    "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
              },
            ),
          );

      log("User registration successful: ${response.data}");
    } catch (e) {
      if (e is DioException) {
        log("Dio Excption: $e");
        ServerFailure.fromDiorError(e);
      }
      log("Error during registration: $e");
    }
  }

  @override
  Future deleteUser(int id) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<int?> getAuthUserId() async {
    return await Pref.getInt(KauthUserId);
  }

  @override
  Future<bool> logout() async {
    try {
      String? refreshToken = await Pref.getRefreshToken(RefreshToken);
      if (refreshToken == null) {
        await _clearUserData();
        return true;
      }

      final response = await getIt
          .get<ApiService>()
          .post(EndPoints.logout, {"refresh_token": "$refreshToken"});
      if (response.statusCode == StatusCode.logedout) {
        await _clearUserData();

        return true;
      } else {
        log("Logout failed: ${response.statusCode} - ${response.data}");
      }
    } catch (e) {
      if (e is DioException) {
        log("Dio Exception: $e");
        ServerFailure.fromDiorError(e);
      }
      log("Error during logout: $e");
    }

    return false;
  }

  Future<void> _clearUserData() async {
    await Pref.remove(KauthUserId);
    await Pref.remove(KIsLogin);
    await Pref.removeSecure(AccessToken);
    await Pref.removeSecure(RefreshToken);
    await Pref.remove(device_id);
  }

  @override
  Future<void> setAuthUserId(int userId) async {
    await Pref.setInt(KauthUserId, userId);
    await Pref.setBool(KIsLogin, true);
  }

  @override
  Future<Either<Failure, Patient>> signinUserWithEmailAndPassword(
      {required SigninUserRequest signinUserRequest}) async {
    try {
      final deviceUuid = getUUIDv4();
      final response = await getIt.get<ApiService>().post(
        EndPoints.login,
        {
          "email": signinUserRequest.email,
          "password": signinUserRequest.password,
          "device_id": deviceUuid,
        },
      );

      if (response.statusCode == StatusCode.ok) {
        final data = response.data["data"];

        if (data?["tokens"] == null || data?["user"] == null) {
          return Left(
              ServerFailure(errorMessage: "Invalid response structure"));
        }

        await Pref.setAccessToken(AccessToken, data["tokens"]["access"]);
        await Pref.setRefreshToken(RefreshToken, data["tokens"]["refresh"]);
        await Pref.saveDeviceId(key: device_id, value: deviceUuid);

        return Right(Patient.fromJson(data["user"]));
      } else {
        return Left(ServerFailure(errorMessage: "Unexpected response status"));
      }
    } on DioException catch (ex) {
      print(ex);
      if (ex is DioException) {
        return Left(ServerFailure.fromDiorError(ex));
      }
      return Left(ServerFailure(errorMessage: "hi ahmed "));
    }
  }
}
