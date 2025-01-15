import 'package:doctors_appointment/core/dumy/dumy_data.dart';
import 'package:doctors_appointment/features/home/data/models/specialist_model.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/special/special_list_card.dart';
import 'package:doctors_appointment/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecialistList extends StatefulWidget {
  const SpecialistList({
    super.key,
  });

  @override
  State<SpecialistList> createState() => _SpecialistListState();
}

class _SpecialistListState extends State<SpecialistList> {
  List<SpecialtyModel> allSpecialites = [];
  @override
  void initState() {
    allSpecialites = context.read<HomeCubit>().allSpecialties;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: allSpecialites.asMap().entries.map((e) {
          return Container(
            margin: EdgeInsets.only(right: 15),
            child: SpecialistCard(
              specialistModel: e.value,
              color: DumyData.specialist[e.key].color,
            ),
          );
        }).toList(),
      ),
    );
  }
}
