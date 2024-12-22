import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:flutter/material.dart';

class ActiveItem extends StatelessWidget {
  const ActiveItem({super.key, required this.icon, required this.label});
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(horizontal: 15),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColor.primaryColor.withOpacity(.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: AppColor.primaryColor,
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              label,
              style: TextStyles.Bold12.copyWith(
                  color: AppColor.primaryColor, fontSize: 13),
            )
          ],
        ));
  }
}
