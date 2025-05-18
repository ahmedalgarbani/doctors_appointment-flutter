import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/features/home/data/models/speciality_response/doctor.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/home_widgets/all_doctor_horizantal_list_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:doctors_appointment/core/router/router.dart';

class AllDoctorsPageViewBody extends StatelessWidget {
  final List<Doctor> doctors;
  final Function(int, int)? onBookingPressed;

  const AllDoctorsPageViewBody({
    super.key,
    required this.doctors,
    this.onBookingPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (doctors.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline, size: 48, color: AppColor.primaryColor),
            const SizedBox(height: 16),
            Text(
              'لا توجد أطباء متاحين حالياً',
              style: TextStyles.Regular16.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: doctors.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final doctor = doctors[index];
        return DoctorListItem(
          doctor: doctor,
          onPressed: () {
            context.push(AppRouter.KDoctorDetail, extra: doctor);
          },
          onBookingPressed: () {
            if (doctor.hospitals != null && doctor.hospitals!.isNotEmpty) {
              onBookingPressed?.call(
                doctor.id?.toInt() ?? 0,
                doctor.hospitals!.first.id?.toInt() ?? 0,
              );
            } else {
              onBookingPressed?.call(doctor.id?.toInt() ?? 0, 0);
            }
          },
        );
      },
    );
  }
}
