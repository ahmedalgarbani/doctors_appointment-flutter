import 'package:doctors_appointment/features/notification/domain/entities/notifications_entity.dart';


class NotificationModel {
  final String message;
  final String status;
  final String notificationType;

  NotificationModel({
    required this.message,
    required this.status,
    required this.notificationType,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      message: json['message'],
      status: json['status'],
      notificationType: json['notification_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      'notification_type': notificationType,
    };
  }

  factory NotificationModel.fromEntity(NotificationsEntity entity) {
    return NotificationModel(
      message: entity.message,
      status: entity.status,
      notificationType: entity.notificationType,
    );
  }

  NotificationsEntity toEntity() {
    return NotificationsEntity(
      message: message,
      status: status,
      notificationType: notificationType,
    );
  }
}
