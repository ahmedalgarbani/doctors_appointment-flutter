import 'package:doctors_appointment/core/dumy/dumy_data.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/special/special_list_card.dart';
import 'package:doctors_appointment/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/speciality_response/speciality_response.dart';

class SpecialistList extends StatefulWidget {
  const SpecialistList({super.key, this.specialities});

  final List<SpecialityResponse>? specialities;
  @override
  State<SpecialistList> createState() => _SpecialistListState();
}

class _SpecialistListState extends State<SpecialistList> {
  @override
  late List<SpecialityResponse> _allSpecialties;

  @override
  void initState() {
    super.initState();
    _allSpecialties =
        widget.specialities ?? context.read<HomeCubit>().allSpecialties;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _allSpecialties.asMap().entries.map((e) {
          return GestureDetector(
            onTap: () {
              setState(() {
                print(e.key);
                context.read<HomeCubit>().getAllDoctors(id: e.key);
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: 15),
              child: SpecialistCard(
                specialistModel: e.value,
                color: DumyData.specialist[e.key].color,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
