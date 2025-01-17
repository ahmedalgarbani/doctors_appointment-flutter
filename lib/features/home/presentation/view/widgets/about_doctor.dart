import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:flutter/material.dart';

class AboutDoctor extends StatelessWidget {
  const AboutDoctor({super.key, required this.about});
  final String about;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About Doctor",
            style: TextStyles.Bold16.copyWith(color: Colors.black),
          ),
          const SizedBox(height: 8.0),
          Text(
            "$about",
            style: TextStyles.Bold12.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
