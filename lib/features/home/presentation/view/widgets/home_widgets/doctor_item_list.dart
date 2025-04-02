import 'package:doctors_appointment/features/home/presentation/view/widgets/home_widgets/doctor_item.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/speciality_response/doctor.dart';

class DoctorItemList extends StatelessWidget {
  const DoctorItemList({super.key, required this.doctorModel});
  final Doctor doctorModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        DoctorItem(
          icon: Icons.favorite,
          count: "155",
          label: "Favorites",
        ),
        DoctorItem(
          icon: Icons.people,
          count: "200",
          label: "Patients",
        ),
        DoctorItem(
          icon: Icons.schedule,
          count: doctorModel.experienceYears.toString(),
          label: "Years",
        ),
      ],
    );
  }
}
