import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:flutter/material.dart';

class AppointmentStatusWidget extends StatelessWidget {
  final AppointmentStatus status;
  final bool compactMode;

  const AppointmentStatusWidget({
    super.key,
    required this.status,
    this.compactMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final statusData = _statusData[status] ?? _unknownStatus;
    final theme = Theme.of(context);

    return Container(
      padding: compactMode
          ? const EdgeInsets.symmetric(horizontal: 8, vertical: 3)
          : const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusData.color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: statusData.color.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!compactMode) ...[
            Icon(
              statusData.icon,
              size: 14,
              color: statusData.color,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            _getLocalizedStatusName(context, statusData.name),
            style: TextStyles.Bold12.copyWith(
              color: statusData.color,
              fontSize: compactMode ? 10 : 12,
            ),
          ),
        ],
      ),
    );
  }

  String _getLocalizedStatusName(BuildContext context, String status) {
    // يمكنك استبدال هذا بمنظومة الترجمة الخاصة بك
    return switch (status.toLowerCase()) {
      'pending' => 'قيد الانتظار',
      'confirmed' => 'مؤكد',
      'cancelled' => 'ملغى',
      'completed' => 'مكتمل',
      _ => 'غير معروف',
    };
  }

  // تعريف بيانات الحالات بشكل أكثر احترافية
  static const _statusData = {
    AppointmentStatus.pending: _StatusData(
      name: 'pending',
      color: Colors.orange,
      icon: Icons.access_time_outlined,
    ),
    AppointmentStatus.confirmed: _StatusData(
      name: 'confirmed',
      color: Colors.green,
      icon: Icons.check_circle_outline,
    ),
    AppointmentStatus.cancelled: _StatusData(
      name: 'cancelled',
      color: Colors.red,
      icon: Icons.cancel_outlined,
    ),
    AppointmentStatus.completed: _StatusData(
      name: 'completed',
      color: Colors.blue,
      icon: Icons.verified_outlined,
    ),
  };

  static const _unknownStatus = _StatusData(
    name: 'unknown',
    color: Colors.grey,
    icon: Icons.help_outline,
  );
}

// أنواع الحالات كـ enum لتحسين سلامة الكود
enum AppointmentStatus {
  pending,
  confirmed,
  cancelled,
  completed,
}

// نموذج بيانات الحالة
class _StatusData {
  final String name;
  final Color color;
  final IconData icon;

  const _StatusData({
    required this.name,
    required this.color,
    required this.icon,
  });
}
