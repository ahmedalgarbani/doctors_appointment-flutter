import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/features/appointment/presentation/view/widgets/appointment_search_filed.dart';
import 'package:flutter/material.dart';

class PastAppointmentView extends StatelessWidget {
  const PastAppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppointmentSearchField(),
            const SizedBox(height: 10),
            Text(
              "Wednesday, 2024-5-11",
              style: TextStyles.Bold16.copyWith(
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            
            // DoctorHorizantalListCard(
            //   trailing: AppointmentStatusWidget(status: 0),
            //   doctorModel: DoctorModel(
            //     name: "Motasem Ahmed",
            //     imagePath: AppImage.doctor03,
            //     Speciality: "Heart",
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
