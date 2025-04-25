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
    return SizedBox(
      height: 270,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: allDoctors.length,
        itemBuilder: (context, index) {
          return Container(
            width: 180,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: DoctorHorizantalListCard(
              onPress: () {
                GoRouter.of(context).push(
                  AppRouter.KDoctorDetail,
                  extra: allDoctors[index],
                );
              },
              doctorModel: allDoctors[index],
            ),
          );
        },
      ),
    );
  }
}
