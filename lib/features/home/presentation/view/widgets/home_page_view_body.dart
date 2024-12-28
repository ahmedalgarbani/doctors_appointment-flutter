import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/doctor_horizantal_list.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/doctor_list.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/home_page_header.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/search_filed.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/section_title.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/special_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePageViewBody extends StatelessWidget {
  const HomePageViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HomePageHeader(
            onPressed: () {
              GoRouter.of(context).push(AppRouter.KNotificationPageView);
            },
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {},
            child: SearchField(),
          ),
          SizedBox(height: 20),
          SectionsTitle(
            title: "Specilty",
            onPressed: () {
              GoRouter.of(context).push(AppRouter.KAllSpecialitesView);
            },
          ),
          SizedBox(
            height: 10,
          ),
          SpecialistList(),
          SizedBox(
            height: 10,
          ),
          SectionsTitle(
            title: "Nearest Doctors",
            onPressed: () {},
          ),
          SizedBox(
            height: 10,
          ),
          DoctorList(),
          SizedBox(
            height: 10,
          ),
          SectionsTitle(
            title: "Top Rating Doctors",
            onPressed: () {
              GoRouter.of(context).push(AppRouter.KTopRatingDoctor);
            },
          ),
          SizedBox(
            height: 10,
          ),
          DoctorHorizantalList(),
        ],
      ),
    );
  }
}
