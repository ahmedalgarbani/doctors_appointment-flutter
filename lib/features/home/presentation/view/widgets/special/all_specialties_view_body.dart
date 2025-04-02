import 'package:doctors_appointment/core/dumy/dumy_data.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/special/special_list_card.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/speciality_response/speciality_response.dart';

// ignore: must_be_immutable
class AllSpecialtiesViewBody extends StatelessWidget {
  AllSpecialtiesViewBody({super.key, this.specialties});
  final List<SpecialityResponse>? specialties;

  @override
  Widget build(BuildContext context) {
    final double itemWidth = 200;
    final double itemHeight = 250;
    final childAspectRatio = itemWidth / itemHeight;

    return GridView.builder(
      itemCount: specialties!.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) {
        return SizedBox(
          width: itemWidth,
          height: itemHeight,
          child: SpecialistCard(
            specialistModel: specialties![index],
            color: DumyData.specialist[index].color,
          ),
        );
      },
    );
  }
}
