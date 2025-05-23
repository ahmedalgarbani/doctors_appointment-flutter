import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/home_widgets/doctor_list_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../data/models/speciality_response/doctor.dart';

class DoctorList extends StatelessWidget {
  DoctorList({
    super.key,
    required this.allDoctors,
  });
  final List<Doctor> allDoctors;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: allDoctors.asMap().entries.map(
          (e) {
            return GestureDetector(
              onTap: () {
                GoRouter.of(context)
                    .push(AppRouter.KDoctorDetail, extra: allDoctors[e.key]);
              },
              child: Container(
                margin: EdgeInsets.only(right: 15),
                child: DoctorListCard(
                  doctorModel: e.value,
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
