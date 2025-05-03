import 'package:doctors_appointment/features/notification/domain/entities/notifications_entity.dart';

class NotificationModel {
  final String message;
  final String status;
  final String notificationType;
  final String createdAt;
  final String senderName;     // ✅
  final String senderEmail;    // ✅

  NotificationModel({
    required this.message,
    required this.status,
    required this.notificationType,
    required this.createdAt,
    required this.senderName,
    required this.senderEmail,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      message: json['message'],
      status: json['status'],
      notificationType: json['notification_type'],
      createdAt: json['created_at'],
      senderName: json['sender_name'],     // ✅
      senderEmail: json['sender_email'],   // ✅
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      'notification_type': notificationType,
      'created_at': createdAt,
      'sender_name': senderName,
      'sender_email': senderEmail,
    };
  }

  factory NotificationModel.fromEntity(NotificationsEntity entity) {
    return NotificationModel(
      message: entity.message,
      status: entity.status,
      notificationType: entity.notificationType,
      createdAt: entity.createdAt,
      senderName: entity.senderName,
      senderEmail: entity.senderEmail,
    );
  }

  NotificationsEntity toEntity() {
    return NotificationsEntity(
      message: message,
      status: status,
      notificationType: notificationType,
      createdAt: createdAt,
      senderName: senderName,
      senderEmail: senderEmail,
    );
  }
}
