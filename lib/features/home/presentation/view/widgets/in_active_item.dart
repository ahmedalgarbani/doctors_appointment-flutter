
import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:flutter/material.dart';

class UnActiveItem extends StatelessWidget {
  const UnActiveItem({super.key, required this.icon});
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColor.primaryColor.withOpacity(.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Icon(
          icon,
          color: AppColor.primaryColor,
        ),
      ),
    );
  }
}
