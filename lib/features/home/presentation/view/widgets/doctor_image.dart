import 'package:doctors_appointment/core/assets_helper/app_image.dart';
import 'package:flutter/material.dart';

class DoctorImage extends StatelessWidget {
  const DoctorImage({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 150,
        width: 140,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Image.asset(
          AppImage.doctor05,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
