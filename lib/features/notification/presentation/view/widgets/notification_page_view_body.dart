import 'package:doctors_appointment/features/notification/domain/entities/notifications_entity.dart';
import 'package:doctors_appointment/features/notification/presentation/view/widgets/notification_card.dart';
import 'package:flutter/material.dart';

class NotificationPageViewBody extends StatelessWidget {
  const NotificationPageViewBody({super.key, required this.notifications});
  final List<NotificationsEntity> notifications;

  @override
  Widget build(BuildContext context) {
    if (notifications.isEmpty) {
      return const Center(child: Text("No notifications."));
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      itemCount: notifications.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final noti = notifications[index];

        return NotificationCardItem(
          title: _getTitleByType(noti.notificationType),
          subtitle: noti.message,
          color: _getColorByType(noti.notificationType),
          iconData: _getIconByType(noti.notificationType),
          isRead: noti.status == '1',
        );
      },
    );
  }

  // Helpers to customize look based on notification_type
  String _getTitleByType(String type) {
    switch (type) {
      case '0':
        return 'Information';
      case '1':
        return 'Warning';
      case '2':
        return 'Success';
      case '3':
        return 'Error';
      default:
        return 'Notification';
    }
  }

  Color _getColorByType(String type) {
    switch (type) {
      case '0':
        return Colors.blueGrey;
      case '1':
        return Colors.orange;
      case '2':
        return Colors.green;
      case '3':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getIconByType(String type) {
    switch (type) {
      case '0':
        return Icons.info;
      case '1':
        return Icons.warning_amber_rounded;
      case '2':
        return Icons.check_circle;
      case '3':
        return Icons.error;
      default:
        return Icons.notifications;
    }
  }
}
