import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/features/home/data/models/speciality_response/doctor.dart';
import 'package:flutter/material.dart';

class OverviewTab extends StatelessWidget {
  final Doctor doctor;

  const OverviewTab({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('نبذة عن الطبيب:', style: TextStyles.Regular16.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            doctor.about ?? 'لا توجد نبذة عن الطبيب.',
            style: TextStyles.Regular16.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
