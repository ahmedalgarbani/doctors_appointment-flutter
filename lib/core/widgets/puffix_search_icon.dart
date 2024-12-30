import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../assets_helper/app_vectors.dart';

class SuffixSearchIcon extends StatelessWidget {
  const SuffixSearchIcon({
    super.key,
    this.onTap,
  });
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: SizedBox(
        height: 20,
        width: 20,
        child: Center(
          child: SvgPicture.asset(AppVectors.search_normal),
        ),
      ),
    );
  }
}
