
import 'package:doctors_appointment/core/models/specialist_model.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SpecialistCard extends StatelessWidget {
  const SpecialistCard({super.key, required this.specialistModel});
  final SpecialistModel specialistModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 24),
      decoration: BoxDecoration(
          color: specialistModel.color,
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          SvgPicture.asset(
            specialistModel.imagePath,
            color: Colors.white,
          ),
          SizedBox(
            height: 15,
          ),
          Text(specialistModel.title, style: TextStyles.Bold16),
          SizedBox(
            height: 5,
          ),
          Text("speciality", style: TextStyles.Bold16),
          SizedBox(
            height: 5,
          ),
          Text("${specialistModel.doctorNumber} doctors",
              style: TextStyles.Bold16)
        ],
      ),
    );
  }
}
