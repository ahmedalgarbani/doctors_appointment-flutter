import 'package:doctors_appointment/core/dumy/dumy_data.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/special_list_card.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AllSpecialtiesViewBody extends StatelessWidget {
  AllSpecialtiesViewBody({super.key});
  final specialty = DumyData.specialist;

  @override
  Widget build(BuildContext context) {
    final double itemWidth = 200;
    final double itemHeight = 250;
    final childAspectRatio = itemWidth / itemHeight;

    return GridView.builder(
      itemCount: specialty.length,
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
          child: SpecialistCard(specialistModel: specialty[index]),
        );
      },
    );
  }
}
