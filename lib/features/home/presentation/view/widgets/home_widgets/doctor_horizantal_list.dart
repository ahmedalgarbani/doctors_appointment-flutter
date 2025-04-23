// ignore_for_file: must_be_immutable

import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/features/home/data/models/speciality_response/doctor.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/home_widgets/doctor_horizantal_list_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DoctorHorizantalList extends StatelessWidget {
  final List<Doctor> allDoctors;
  DoctorHorizantalList({Key? key, required this.allDoctors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: allDoctors.length,
      itemBuilder: (context, index) {
        return DoctorHorizantalListCard(
          onPress: () {
            GoRouter.of(context).push(AppRouter.KDoctorDetail,
                extra: allDoctors[index] as Doctor);
          },
          doctorModel: allDoctors[index],
        );
      },
    );
  }
}
