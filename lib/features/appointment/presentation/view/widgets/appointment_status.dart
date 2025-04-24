import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:flutter/material.dart';

class AppointmentStatusWidget extends StatelessWidget {
  final String status;

  final List<Map<String, dynamic>> statusList = [
    {
      'code': 0,
      'name': 'pending',
      'color': Colors.orange,
    },
    {
      'code': 1,
      'name': 'confirmed',
      'color': Colors.green,
    },
    {
      'code': 2,
      'name': 'cancelled',
      'color': Colors.red,
    },
    {
      'code': 3,
      'name': 'completed',
      'color': const Color.fromARGB(255, 0, 72, 255),
    },
  ];

  AppointmentStatusWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final statusData = statusList.firstWhere(
      (e) => e['name'].toLowerCase() == status.toLowerCase(), 
      orElse: () => {'name': 'Unknown', 'color': Colors.grey},
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: (statusData['color'] as Color).withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        statusData['name'] as String,
        style: TextStyles.Bold12.copyWith(
          color: statusData['color'] as Color,
          fontSize: 10,
        ),
      ),
    );
  }
}
