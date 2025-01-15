import 'package:doctors_appointment/core/constant/constant.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/special/all_specialties_view_body.dart';
import 'package:doctors_appointment/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/specialist_model.dart';

class AllSpecialtiesView extends StatefulWidget {
  const AllSpecialtiesView({super.key});

  @override
  State<AllSpecialtiesView> createState() => _AllSpecialtiesViewState();
}

class _AllSpecialtiesViewState extends State<AllSpecialtiesView> {
  List<SpecialtyModel> allSpecialites = [];

  @override
  void initState() {
    allSpecialites = BlocProvider.of<HomeCubit>(context).allSpecialties;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Specialist Doctor",
          style: TextStyles.Black20Bold.copyWith(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        child: AllSpecialtiesViewBody(
          specialties: allSpecialites,
        ),
      )),
    );
  }
}
