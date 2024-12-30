
import 'package:doctors_appointment/features/home/presentation/view/widgets/home_widgets/doctor_item.dart';
import 'package:flutter/material.dart';

class DoctorItemList extends StatelessWidget {
  const DoctorItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
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
          count: "24",
          label: "Years",
        ),
      ],
    );
  }
}