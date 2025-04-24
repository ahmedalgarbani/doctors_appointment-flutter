import 'package:doctors_appointment/core/assets_helper/app_vectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptySearch extends StatelessWidget {
  const EmptySearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(AppVectors.search_empty),
    );
  }
}
