// ignore_for_file: must_be_immutable

import 'package:doctors_appointment/core/assets_helper/app_image.dart';
import 'package:doctors_appointment/core/dumy/dumy_data.dart';
import 'package:doctors_appointment/core/models/doctor_model.dart';
import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/core/widgets/appbar.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/home_widgets/doctor_horizantal_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/widgets/empty_search.dart';
import 'search_field_page_view.dart';

class SearchPageViewBody extends StatelessWidget {
  SearchPageViewBody({super.key, required this.textString});
  final String textString;
  bool isEmpty = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseAppBar(
            title: Text(
              "Search",
              style: TextStyles.Black20Bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SearchFieldPageView(),
          SizedBox(
            height: 20,
          ),
          if (isEmpty) EmptySearch(),
          if (!isEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recent Search",
                  style: TextStyles.Bold16.copyWith(
                    color: AppColor.primaryColor,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                DoctorHorizantalListCard(
                  onPress: () {
                    GoRouter.of(context).push(AppRouter.KDoctorDetail);
                  },
                  doctorModel: DoctorModel(
                      name: "Ahmed",
                      imagePath: AppImage.doctor03,
                      Speciality: DumyData.specialist[0].title),
                ),
                DoctorHorizantalListCard(
                  onPress: () {
                    GoRouter.of(context).push(AppRouter.KDoctorDetail);
                  },
                  doctorModel: DoctorModel(
                      name: "Motassem",
                      imagePath: AppImage.doctor02,
                      Speciality: DumyData.specialist[2].title),
                ),
                DoctorHorizantalListCard(
                  onPress: () {
                    GoRouter.of(context).push(AppRouter.KDoctorDetail);
                  },
                  doctorModel: DoctorModel(
                      name: "Mossa",
                      imagePath: AppImage.doctor04,
                      Speciality: DumyData.specialist[3].title),
                ),
                DoctorHorizantalListCard(
                  onPress: () {
                    GoRouter.of(context).push(AppRouter.KDoctorDetail);
                  },
                  doctorModel: DoctorModel(
                      name: "Yasser",
                      imagePath: AppImage.doctor05,
                      Speciality: DumyData.specialist[4].title),
                ),
              ],
            )
        ],
      ),
    );
  }
}
