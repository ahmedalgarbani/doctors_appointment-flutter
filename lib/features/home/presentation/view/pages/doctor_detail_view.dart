import 'package:doctors_appointment/features/home/data/models/speciality_response/doctor.dart';

import '../widgets/doctor_scedual_bottom_sheet.dart';
import '/core/style/app_color.dart';
import '/core/style/text_style.dart';
import '/core/widgets/custom_button.dart';
import '/features/home/presentation/view/widgets/about_doctor.dart';
import '/features/home/presentation/view/widgets/home_widgets/doctor_image.dart';
import '/features/home/presentation/view/widgets/home_widgets/doctor_item_list.dart';
import '/features/home/presentation/view/widgets/home_widgets/favorite_button_cubit.dart';
import '/features/home/presentation/view/widgets/location_doctor.dart';
import '/features/home/presentation/view/widgets/top_rating_doctor/starts_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../view_model/cubit/favorites_cubit/favorites_cubit.dart';

class DoctorDetailView extends StatelessWidget {
  const DoctorDetailView({super.key, required this.doctorModel});
  final Doctor doctorModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
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
                        decoration: const BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                        ),
                        child: Column(
                          children: [
                            DoctorImage(
                              doctorImage: doctorModel.photo ?? '',
                              doctorId: doctorModel.id!.toInt(),
                            ),
                            const SizedBox(height: 20),
                            DoctorItemList(doctorModel: doctorModel),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              doctorModel.fullName??'',
                              style: TextStyles.Regular16,
                            ),
                            Text(
                              doctorModel.fullName ?? 'Unknown Specialty',
                              style: TextStyles.Regular16.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const StarsSection(),
                            const SizedBox(height: 16),
                            AboutDoctor(about: doctorModel.subTitle ?? ''),
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
                      builder: (context) => DoctorScedualBottomSheet(
                        doctorModel: doctorModel,
                      ),
                    );
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

  AppBar _buildAppBar(BuildContext context) {
    final favoritesCubit = BlocProvider.of<FavoritesCubit>(context);

    return AppBar(
      actions: [
        FavoriteButtonCubit(
            doctorModel: doctorModel,
            favoritesCubit: favoritesCubit,
            isDetailButtton: true)
      ],
      elevation: 0,
      leading: InkWell(
        onTap: () => GoRouter.of(context).pop(),
        child: Container(
          margin: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: AppColor.primaryColor,
    );
  }
}
