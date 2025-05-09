import 'dart:io';
import 'package:dio/dio.dart';
import 'package:doctors_appointment/core/constant/constant.dart';
import 'package:doctors_appointment/core/helpers/shared_prefrace.dart';
import 'package:doctors_appointment/core/network/status_code.dart';


import '../services/api_service.dart';
import '../services/get_it.dart';
import 'end_points.dart';

class AppIntercepters extends Interceptor {
  final Dio client;

  AppIntercepters({required this.client});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers[HttpHeaders.acceptHeader] = ContentType.json.mimeType;
    String? deviceUuid = await Pref.loadDeviceId(device_id);
    String? userAccessToken = await Pref.getAccessToken(AccessToken);
    String? refresh = await Pref.getRefreshToken(RefreshToken);
    if (userAccessToken != null && userAccessToken.isNotEmpty) {
      options.headers[HttpHeaders.authorizationHeader] =
          '$bearer $userAccessToken';
    }
    // if (deviceUuid != null && deviceUuid.isNotEmpty) {
    //   options.headers["device_id"] = deviceUuid;
    // }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // debugPrint(
    //     'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
  if (err.response?.statusCode == StatusCode.unauthorized) {
    final refreshToken = await Pref.getRefreshToken(RefreshToken);
    if (refreshToken != null && refreshToken.isNotEmpty) {
      if (await _refreshToken(refreshToken)) {
        try {
          final response = await _retry(err.requestOptions);
          handler.resolve(response);
          return; 
        } catch (e) {
          await _logout();
          handler.next(err); 
          return;
        }
      } else {
        await _logout();
        handler.next(err); 
        return;
      }
    } else {
      await _logout();
      handler.next(err); 
      return;
    }
  }
  handler.next(err);
}

Future<void> _logout() async {
    await Pref.remove(KauthUserId);
    await Pref.remove(KIsLogin);
    await Pref.removeSecure(AccessToken);
    await Pref.removeSecure(RefreshToken);
    await Pref.remove(device_id);
}


  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    String? newAccessToken = await Pref.getAccessToken(AccessToken);
    String? newRefreshToken = await Pref.getRefreshToken(RefreshToken);

    if (newAccessToken != null && newAccessToken.isNotEmpty) {
      requestOptions.headers[HttpHeaders.authorizationHeader] =
          '$bearer $newAccessToken';
    }

    final options =
        Options(method: requestOptions.method, headers: requestOptions.headers);

    Map<String, dynamic> requestData = requestOptions.data ?? {};
    requestData['refresh_token'] = newRefreshToken;
    return client.request<dynamic>(
      requestOptions.path,
      data: requestData,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  static Future<bool> _refreshToken(String userRefreshToken) async {
    try {
      final response = await getIt.get<ApiService>().post(
        
        EndPoints.refreshToken,
        data:{
          "$refreshTokenRequest": "${userRefreshToken}",

        },
        
        // options: Options(
        //   headers: {
        //     HttpHeaders.authorizationHeader: '',
        //   },
        // ),
      );

      if (response.statusCode == StatusCode.ok) {
        final responseData = response.data;
        // log("response [$responseData]");
        final String? newAccessToken = responseData["access"];
        final String? newRefreshToken = responseData["refresh"];

        if (newAccessToken != null && newRefreshToken != null) {
          await Pref.setAccessToken(AccessToken, newAccessToken);
          await Pref.setRefreshToken(RefreshToken, newRefreshToken);
          return true;
        }
      } else {
            return false;

        // debugPrint("Unexpected response: ${response.data}");
      }
    } catch (e) {
          return false;

      // debugPrint("Error refreshing token: $e");
    }
    return false;
  }
}
