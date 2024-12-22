
import 'package:doctors_appointment/core/dumy/dumy_data.dart';
import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/doctor_horizantal_list_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DoctorHorizantalList extends StatelessWidget {
  const DoctorHorizantalList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            GoRouter.of(context).push(AppRouter.KDoctorDetail);
          },
          child: DoctorHorizantalListCard(
            doctorModel: DumyData.doctorlist[index],
          ),
        );
      },
    );
  }
}