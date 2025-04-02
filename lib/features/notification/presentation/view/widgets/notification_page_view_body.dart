import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/features/notification/presentation/view/widgets/notification_card.dart';
import 'package:flutter/material.dart';

class NotificationPageViewBody extends StatelessWidget {
  const NotificationPageViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            "2025-10-4",
            style: TextStyles.Bold16.copyWith(color: Colors.black),
          ),
          NotificationCardItem(
            title: "Appointment Alert",
            subtitle:
                "we have a new appointment and will be updated to the new appoi",
            color: Colors.red,
            iconData: Icons.access_alarm_rounded,
          ),
          NotificationCardItem(
            title: "Appointment Confirm",
            subtitle:
                "we have a new appointment and will be updated to the new appoi",
            color: Color.fromARGB(255, 3, 90, 252),
            iconData: Icons.done,
          ),
        ],
      ),
    );
  }
}
