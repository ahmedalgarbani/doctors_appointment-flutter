import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:flutter/material.dart';

class DoctorItem extends StatelessWidget {
  final IconData icon;
  final String count;
  final String label;

  const DoctorItem({
    required this.icon,
    required this.count,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: AppColor.secondaryColor,
          child: Icon(icon, color: Colors.white),
        ),
        Text(
          count,
          style: TextStyles.Bold12.copyWith(color: Colors.white),
        ),
        Text(
          label,
          style: TextStyles.Bold12.copyWith(fontSize: 10, color: Colors.white),
        ),
      ],
    );
  }
}
