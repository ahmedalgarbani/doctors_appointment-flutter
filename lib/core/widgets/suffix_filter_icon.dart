
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../assets_helper/app_vectors.dart';
import '../style/app_color.dart';

class SuffixFilterIcon extends StatelessWidget {
  const SuffixFilterIcon({
    super.key,
    this.onTap,
  });
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColor.primaryColor,
        ),
        height: 20,
        width: 20,
        child: Center(
          child: SvgPicture.asset(
            AppVectors.filter_search,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}