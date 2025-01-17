import 'package:doctors_appointment/core/assets_helper/app_image.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:flutter/material.dart';

class LocationDoctor extends StatelessWidget {
  const LocationDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Location Doctor",
            style: TextStyles.Bold16.copyWith(color: Colors.black),
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                AppImage.location,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
