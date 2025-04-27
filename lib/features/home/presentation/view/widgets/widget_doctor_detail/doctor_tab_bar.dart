import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:flutter/material.dart';

class DoctorTabBar extends StatelessWidget {
  final TabController controller;

  const DoctorTabBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 3)),
        ],
      ),
      child: TabBar(
        controller: controller,
        labelColor: Colors.white,
        unselectedLabelColor: AppColor.primaryColor,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.primaryColor,
        ),
        tabs: const [
          Tab(icon: Icon(Icons.info_outline), text: 'نظرة عامة'),
          Tab(icon: Icon(Icons.local_hospital), text: 'مستشفى'),
          Tab(icon: Icon(Icons.star_outline), text: 'التقييمات'),
        ],
      ),
    );
  }
}
