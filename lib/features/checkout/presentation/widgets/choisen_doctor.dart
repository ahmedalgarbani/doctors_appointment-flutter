
import 'package:doctors_appointment/core/assets_helper/app_image.dart';
import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:flutter/material.dart';

class ChosenDoctor extends StatelessWidget {
  const ChosenDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        trailing: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColor.secondaryColor,
          ),
          child: Text(
            "\$250",
            style: TextStyles.Bold16.copyWith(color: Colors.black),
          ),
        ),
        subtitle: Text(
          "heart",
          style: TextStyles.Bold12.copyWith(color: Colors.grey),
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            AppImage.doctor04,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          "Ahmed MOhamed",
          style: TextStyles.Bold16.copyWith(color: Colors.black),
        ),
      ),
    );
  }
}
