
import 'package:flutter/material.dart';

import '../../../../../core/style/app_color.dart';
import '../../../../../core/style/text_style.dart';

class FilterCard extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const FilterCard({
    required this.title,
    required this.isActive,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isActive ? AppColor.primaryColor : AppColor.whiteBackgrond,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyles.Bold12.copyWith(
              color: isActive ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
