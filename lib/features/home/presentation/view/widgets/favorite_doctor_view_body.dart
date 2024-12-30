import 'package:doctors_appointment/features/home/presentation/view/widgets/home_widgets/doctor_horizantal_list.dart';
import 'package:flutter/material.dart';

class FavoriteDoctorViewBody extends StatelessWidget {
  const FavoriteDoctorViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: DoctorHorizantalList());
  }
}