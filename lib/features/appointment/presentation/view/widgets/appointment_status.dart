import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:flutter/material.dart';

class AppointmentStatusWidget extends StatelessWidget {
  final int status;

  final List<Map<String, dynamic>> statusList = [
    {
      'code': 0,
      'name': 'Pending',
      'color': Colors.orange,
    },
    {
      'code': 1,
      'name': 'Complete',
      'color': Colors.green,
    },
    {
      'code': 2,
      'name': 'Declined',
      'color': Colors.red,
    },
  ];

  AppointmentStatusWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final statusData = statusList[status];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: statusData['color'].withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        statusData['name'],
        style: TextStyles.Bold12.copyWith(
          color: statusData['color'],
          fontSize: 10,
        ),
      ),
    );
  }
}
