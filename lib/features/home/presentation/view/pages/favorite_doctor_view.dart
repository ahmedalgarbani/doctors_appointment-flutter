import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/favorite_doctor_view_body.dart';
import 'package:flutter/material.dart';

class FavoriteDoctorView extends StatelessWidget {
  const FavoriteDoctorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Top Doctors",
          style: TextStyles.Black20Bold.copyWith(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        actions: [
          Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColor.secondaryColor),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Center(
              child: Icon(
                Icons.sort,
                color: AppColor.primaryColor,
              ),
            ),
          )
        ],
      ),
      body: FavoriteDoctorViewBody(),
    );
  }
}
