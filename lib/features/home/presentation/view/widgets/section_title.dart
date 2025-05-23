//section_title.dart
import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:flutter/material.dart';

class SectionsTitle extends StatelessWidget {
  const SectionsTitle({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyles.Black20Bold,
        ),
        const Spacer(),
        InkWell(
          onTap: onPressed,
          child: Row(
            children: [
              Text(
                "عرض الكل",
                style:
                    TextStyles.Regular16.copyWith(color: AppColor.primaryColor),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ],
    );
  }
}
