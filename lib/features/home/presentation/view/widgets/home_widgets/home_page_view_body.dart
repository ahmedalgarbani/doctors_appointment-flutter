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
          const SizedBox(
            height: 20,
          ),
          SearchFieldPageView(
            filter: false,
            onPress: () {
              GoRouter.of(context).push(AppRouter.KSearchPage);
            },
          ),
          const SizedBox(height: 20),
          SectionsTitle(
            title: "Specilty",
            onPressed: () {
              GoRouter.of(context).push(AppRouter.KAllSpecialitesView);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          const SpecialistList(),
          const SizedBox(
            height: 10,
          ),
          
          const SizedBox(
            height: 10,
          ),
          SectionsTitle(
            title: "Doctors",
            onPressed: () {
              GoRouter.of(context).push(AppRouter.KTopRatingDoctor);
            },
          ),
          const SizedBox(
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
