import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/in_active_item.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/top_rating_doctor/top_rating_doctor_page_view_body.dart';
import 'package:flutter/material.dart';

class TopRatingDoctorPageView extends StatelessWidget {
  const TopRatingDoctorPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Top Rating Doctors",
          style: TextStyles.Bold16.copyWith(color: Colors.black),
        ),
        actions: [UnActiveItem(icon: Icons.sort)],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TopRatingDoctorPageViewBody(),
        ),
      ),
    );
  }
}
