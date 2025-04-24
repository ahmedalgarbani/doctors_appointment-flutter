import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/home_widgets/home_page_header.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/section_title.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/special/special_list.dart';
import 'package:doctors_appointment/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:doctors_appointment/features/home/presentation/view_model/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/helpers/build_snacbar.dart';
import '../../../../../search/presentation/view/widgets/search_field_page_view.dart';
import 'doctor_horizantal_list.dart';

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
          BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is HomeFailure) {
                buildSnackbar(context, state.message);
              }
            },
            buildWhen: (pp, cc) {
              return cc is SpecialtiesLoaded;
            },
            builder: (context, state) {
              if (state is SpecialtiesLoaded) {
                return SpecialistList(specialities: state.specialties);
              } else {
                return SizedBox();
              }
            },
          ),
          // const SizedBox(
          //   height: 10,
          // ),
          // SectionsTitle(
          //   title: "Doctors",
          //   onPressed: () {
          //     GoRouter.of(context).push(AppRouter.KallDoctors);
          //   },
          // ),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (pre, curre) {
              return curre is DoctorsLoaded;
            },
            builder: (context, state) {
              if (state is DoctorsLoaded)
                return Column(children: [
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  SectionsTitle(
                    title: "Doctors",
                    onPressed: () {
                      GoRouter.of(context)
                          .push(AppRouter.KallDoctors, extra: state.doctors);
                    },
                  ),
                  DoctorHorizantalList(
                    allDoctors: state.doctors,
                  ),
                ]);

              return SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
