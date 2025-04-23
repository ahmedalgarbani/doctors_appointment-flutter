import 'dart:developer';

import 'package:doctors_appointment/core/network/end_points.dart';
import 'package:doctors_appointment/core/services/api_service.dart';
import 'package:doctors_appointment/core/services/get_it.dart';
import 'package:doctors_appointment/features/notification/domain/entities/notifications_entity.dart';
import '../../domain/repositories/notification_repo.dart';
import '../models/notifications_model.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  var _dio = getIt.get<ApiService>();

  @override
  Future<List<NotificationsEntity>> getAllNotifications() async {
    try {
      final response = await _dio.get(EndPoints.notifications);
      List data = response.data['results'];
      log(data.toString());

      // return data.map((json) => NotificationModel.fromJson(json)).toList();
      return data
          .map((json) => NotificationModel.fromJson(json).toEntity())
          .toList();
    } catch (e) {
      throw Exception('Failed to load notifications: $e');
    }
  }
}
