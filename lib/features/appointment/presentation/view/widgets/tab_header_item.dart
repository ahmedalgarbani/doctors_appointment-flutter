import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:flutter/material.dart';

class TabHeaderItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const TabHeaderItem({
    super.key,
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: isActive ? AppColor.primaryColor : Colors.transparent,
          border: Border.all(color: AppColor.primaryColor, width: 1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          title,
          style: TextStyles.Bold16.copyWith(
            color: isActive ? Colors.white : AppColor.primaryColor,
          ),
        ),
      ),
    );
  }
}
