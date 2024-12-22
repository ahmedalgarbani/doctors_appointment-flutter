import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/core/widgets/custom_button.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/about_doctor.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/choose_date_snack_bar.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/doctor_image.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/doctor_item_list.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/location_doctor.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/starts_section.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DoctorDetailView extends StatelessWidget {
  const DoctorDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBAr(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25))),
                        child: Column(
                          children: [
                            const DoctorImage(),
                            const SizedBox(height: 20),
                            const DoctorItemList(),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              "Ahmed Mohamed AlGarbani",
                              style: TextStyles.Regular16,
                            ),
                            Text(
                              "Heart Doctor",
                              style: TextStyles.Regular16.copyWith(
                                  color: Colors.grey),
                            ),
                            const SizedBox(height: 16),
                            const StarsSection(),
                            const SizedBox(height: 16),
                            const AboutDoctor(),
                            const SizedBox(height: 20),
                            const LocationDoctor(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: CustomButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const ChooseDateScnakBar();
                        });
                  },
                  title: "Make Appointment",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBAr(context) {
    return AppBar(
      elevation: 0,
      leading: InkWell(
        onTap: () {
          GoRouter.of(context).pop();
        },
        child: Container(
          margin: EdgeInsets.all(7),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: AppColor.primaryColor,
    );
  }
}
