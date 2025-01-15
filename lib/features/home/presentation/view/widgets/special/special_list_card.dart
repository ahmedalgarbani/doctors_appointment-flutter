
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/features/home/data/models/specialist_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SpecialistCard extends StatelessWidget {
  const SpecialistCard({super.key,  this.specialistModel,this.color});
  final SpecialtyModel? specialistModel;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 24),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          SvgPicture.asset(
            specialistModel!.image!,
            color: Colors.white,
          ),
          SizedBox(
            height: 15,
          ),
          Text(specialistModel!.name, style: TextStyles.Bold16),
          SizedBox(
            height: 5,
          ),
          Text("speciality", style: TextStyles.Bold16),
          SizedBox(
            height: 5,
          ),
          Text("15 doctors",
              style: TextStyles.Bold16)
        ],
      ),
    );
  }
}
