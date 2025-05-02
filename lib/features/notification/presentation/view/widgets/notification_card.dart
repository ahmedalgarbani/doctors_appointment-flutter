import 'package:flutter/material.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/features/notification/domain/entities/notifications_entity.dart';

class NotificationItem extends StatelessWidget {
  final NotificationsEntity notification;
  final bool isRead;

  const NotificationItem({
    super.key,
    required this.notification,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isRead
            ? isDarkMode
                ? Colors.grey[850]
                : const Color(0xFFF9FAFB)
            : isDarkMode
                ? Colors.grey[800]
                : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black : Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getBadgeColor(notification.notificationType)
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getNotificationIcon(notification.notificationType),
                        size: 14,
                        color: _getBadgeColor(notification.notificationType),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _getNotificationTypeText(notification.notificationType),
                        style: TextStyles.Regular12.copyWith(
                          color: _getBadgeColor(notification.notificationType),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "2023-05-15\n10:30 AM",
                  textAlign: TextAlign.end,
                  style: TextStyles.Regular12.copyWith(
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    height: 1.4,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              notification.message,
              style: TextStyles.Regular14.copyWith(
                color: isDarkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[700] : Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "من: محمد أحمد",
                    style: TextStyles.Regular12.copyWith(
                      color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "mohamed@example.com",
                    style: TextStyles.Regular12.copyWith(
                      color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // بقية الدوال كما هي بدون تغيير
  Color _getBadgeColor(String type) {
    switch (type) {
      case '0':
        return const Color(0xFF3B82F6);
      case '1':
        return const Color(0xFFF59E0B);
      case '2':
        return const Color(0xFF10B981);
      case '3':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF6B7280);
    }
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case '0':
        return Icons.info_outline;
      case '1':
        return Icons.warning_amber_outlined;
      case '2':
        return Icons.check_circle_outline;
      case '3':
        return Icons.error_outline;
      default:
        return Icons.notifications_none;
    }
  }

  String _getNotificationTypeText(String type) {
    switch (type) {
      case '0':
        return 'معلومة';
      case '1':
        return 'تحذير';
      case '2':
        return 'نجاح';
      case '3':
        return 'خطأ';
      default:
        return 'إشعار';
    }
  }
}
