
import 'package:doctors_appointment/core/dumy/dumy_data.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/doctor_list_card.dart';
import 'package:flutter/material.dart';

class DoctorList extends StatelessWidget {
  const DoctorList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: DumyData.doctorlist.asMap().entries.map((e) {
          return Container(
            margin: EdgeInsets.only(right: 15),
            child: DoctorListCard(
              doctorModel: e.value,
            ),
          );
        }).toList(),
      ),
    );
  }
}