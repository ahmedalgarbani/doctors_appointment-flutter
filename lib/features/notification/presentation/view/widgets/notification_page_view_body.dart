import 'package:doctors_appointment/features/notification/domain/entities/notifications_entity.dart';
import 'package:doctors_appointment/features/notification/presentation/view/widgets/notification_card.dart';
import 'package:flutter/material.dart';

class NotificationPageViewBody extends StatelessWidget {
  const NotificationPageViewBody({super.key, required this.notifications});
  final List<NotificationsEntity> notifications;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_off_outlined,
              size: 48,
              color: isDarkMode ? Colors.grey[500] : Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              "لا توجد إشعارات",
              style: TextStyle(
                fontSize: 16,
                color: isDarkMode ? Colors.grey[400] : Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final noti = notifications[index];
        return NotificationItem(
          notification: noti,
          isRead: noti.status == '1',
        );
      },
    );
  }
}
