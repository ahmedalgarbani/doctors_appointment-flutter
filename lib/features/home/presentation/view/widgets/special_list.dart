
import 'package:doctors_appointment/core/dumy/dumy_data.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/special_list_card.dart';
import 'package:flutter/material.dart';

class SpecialistList extends StatelessWidget {
  const SpecialistList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: DumyData.specialist.asMap().entries.map((e) {
          return Container(
            margin: EdgeInsets.only(right: 15),
            child: SpecialistCard(
              specialistModel: e.value,
            ),
          );
        }).toList(),
      ),
    );
  }
}
