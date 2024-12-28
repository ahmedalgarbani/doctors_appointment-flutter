import 'package:doctors_appointment/core/constant/constant.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/all_specialties_view_body.dart';
import 'package:flutter/material.dart';

class AllSpecialtiesView extends StatelessWidget {
  const AllSpecialtiesView({super.key});

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
        padding: const EdgeInsets.symmetric(
            vertical: KVerticalPadding, horizontal: KHorizantalPadding),
        child: AllSpecialtiesViewBody(),
      )),
    );
  }
}
