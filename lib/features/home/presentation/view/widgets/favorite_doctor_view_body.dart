import 'package:doctors_appointment/features/home/presentation/view/widgets/home_widgets/doctor_horizantal_list.dart';
import 'package:flutter/material.dart';

import '../../../../../core/style/app_color.dart';
import '../../../../../core/style/text_style.dart';
import '../../../data/models/doctor_model.dart';

class FavoriteDoctorViewBody extends StatelessWidget {
  const FavoriteDoctorViewBody({super.key, required this.allDoctors});
  final List<DoctorModel> allDoctors;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Text(
                  "Favorites Doctors",
                  style: TextStyles.Black20Bold.copyWith(color: Colors.black),
                ),
                Spacer(),
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
          ),
          DoctorHorizantalList(
            allDoctors: allDoctors,
          )
        ],
      ),
    );
  }
}
