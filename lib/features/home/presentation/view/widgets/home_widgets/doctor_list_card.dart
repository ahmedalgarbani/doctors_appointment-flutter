
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/doctor_model.dart';

class DoctorListCard extends StatelessWidget {
  const DoctorListCard({super.key, required this.doctorModel});
  final DoctorModel doctorModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.asset(
                doctorModel.imagePath!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  doctorModel.name,
                  style: TextStyles.Bold12,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  doctorModel.specialtyName.toString(),
                  style:
                      TextStyles.Bold12.copyWith(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
