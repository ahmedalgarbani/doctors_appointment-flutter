import 'package:doctors_appointment/features/notification/domain/entities/notifications_entity.dart';

import '../../data/models/notifications_model.dart';

abstract class NotificationRepository {
  Future<List<NotificationsEntity>> getAllNotifications();
}
