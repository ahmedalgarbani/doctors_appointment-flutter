import 'package:doctors_appointment/core/assets_helper/app_vectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoConnectionViewBody extends StatelessWidget {
  const NoConnectionViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SvgPicture.asset(AppVectors.no_internet_connection),
      ),
    );
  }
}