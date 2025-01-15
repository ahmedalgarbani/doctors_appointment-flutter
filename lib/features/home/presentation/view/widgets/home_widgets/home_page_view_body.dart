import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/home_widgets/doctor_list.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/home_widgets/home_page_header.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/section_title.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/special/special_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../search/presentation/view/widgets/search_field_page_view.dart';
import '../../../../data/models/doctor_model.dart';
import 'doctor_horizantal_list.dart';

class HomePageViewBody extends StatelessWidget {
  const HomePageViewBody({super.key, this.allDoctors});
  final List<DoctorModel>? allDoctors;

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
          SearchFieldPageView(
            onPress: () {
              GoRouter.of(context).push(AppRouter.KSearchPage);
            },
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
          DoctorList(
            allDoctors: allDoctors!,
          ),
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
          DoctorHorizantalList(
            allDoctors: allDoctors!,
          ),
        ],
      ),
    );
  }
}
