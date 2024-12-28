
import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:flutter/material.dart';

class NotificationCardItem extends StatelessWidget {
  const NotificationCardItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.iconData,
  });
  final String title, subtitle;
  final Color color;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.secondaryColor.withOpacity(.8),
      elevation: 0,
      child: ListTile(
        title: Text(
          title,
          style: TextStyles.Bold16.copyWith(color: Colors.black),
        ),
        subtitle: Text(
          subtitle,
        ),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(
            child: Icon(
              iconData,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
