import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/speciality_response/speciality_response.dart';

class SpecialistCard extends StatelessWidget {
  const SpecialistCard({super.key, this.specialistModel, this.color});
  final SpecialityResponse? specialistModel;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 24),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Flexible(
            child: Image.network(
              specialistModel!.image!,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(specialistModel!.name!, style: TextStyles.Bold16),
          SizedBox(
            height: 5,
          ),
          Text("speciality", style: TextStyles.Bold16),
          SizedBox(
            height: 5,
          ),
          Text("${specialistModel!.doctors?.length} doctors",
              style: TextStyles.Bold16)
        ],
      ),
    );
  }
}
