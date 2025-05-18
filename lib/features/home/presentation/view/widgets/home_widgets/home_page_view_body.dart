import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/home_widgets/home_page_header.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/section_title.dart'; // استيراد الوجت
import 'package:doctors_appointment/features/home/presentation/view/widgets/special/special_list.dart';
import 'package:doctors_appointment/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:doctors_appointment/features/home/presentation/view_model/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/helpers/build_snacbar.dart';
import '../../../../../blog/presentation/cubit/blog_cubit.dart';
import '../../../../../blog/presentation/view/widgets/blog_card.dart';
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
          const SizedBox(height: 20),
          SearchFieldPageView(
            filter: false,
            onPress: () {
              GoRouter.of(context).push(AppRouter.KSearchPage);
            },
          ),
          const SizedBox(height: 20),
          
          // SectionsTitle للتخصصات
          SectionsTitle(
            title: "Specialty",
            onPressed: () {
              GoRouter.of(context).push(AppRouter.KAllSpecialitesView);
            },
          ),
          const SizedBox(height: 10),
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
          const SizedBox(height: 10),

          // SectionsTitle للأطباء
          BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (pre, curre) {
              return curre is DoctorsLoaded;
            },
            builder: (context, state) {
              if (state is DoctorsLoaded)
                return Column(children: [
                  SectionsTitle(
                    title: "Doctors",
                    onPressed: () {
                      GoRouter.of(context)
                          .push(AppRouter.KallDoctors, extra: state.doctors);
                    },
                  ),
                  const SizedBox(height: 10),
                  DoctorHorizantalList(
                    allDoctors: state.doctors,
                  ),
                ]);
              return SizedBox();
            },
          ),
          const SizedBox(height: 20),

          // Blog Section باستخدام SectionsTitle
          SectionsTitle(
            title: "Latest Articles",
            onPressed: () {
              GoRouter.of(context).push(AppRouter.KBlogListPage);
            },
          ),
          const SizedBox(height: 8),
          BlocProvider(
            create: (context) => BlogCubit(),
            child: BlocBuilder<BlogCubit, BlogState>(
              builder: (context, state) {
                if (state is BlogLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is BlogError) {
                  return Center(child: Text(state.message));
                } else if (state is BlogLoaded) {
                  return SizedBox(
                    height: 320,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: state.posts.length,
                      itemBuilder: (context, index) {
                        final post = state.posts[index];
                        return Container(
                          width: 280,
                          margin: EdgeInsets.only(right: 16),
                          child: BlogCard(
                            post: post,
                            onTap: () {
                              GoRouter.of(context).push(
                                AppRouter.KBlogDetailPage,
                                extra: post,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
