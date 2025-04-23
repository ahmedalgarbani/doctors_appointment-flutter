import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/in_active_item.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/top_rating_doctor/all_doctors_page_view_body.dart';
import 'package:flutter/material.dart';

import '../../../../../core/style/app_color.dart';
import '../../../../search/presentation/view/widgets/filter_bottom_sheet.dart';
import '../../../data/models/speciality_response/doctor.dart';

class AllDoctorsPageView extends StatelessWidget {
  const AllDoctorsPageView({super.key, this.allDoctors});
  final List<Doctor>? allDoctors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "All Doctors",
          style: TextStyles.Bold16.copyWith(color: Colors.black),
        ),
        actions: [
          UnActiveItem(
            icon: Icons.sort,
            onPressed: () {
              _showFilterBottomSheet(context,);
            },
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: AllDoctorsPageViewBody(
            doctors: allDoctors?.length == 0 || allDoctors == null
                ? []
                : allDoctors!,
          ),
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: AppColor.whiteBackgrond,
      isScrollControlled: true,
      builder: (context) => const FilterBottomSheet(),
    );
  }
}
