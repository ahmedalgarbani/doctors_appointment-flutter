import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmptyAppointmentView extends StatelessWidget {
  const EmptyAppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          const Spacer(),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: AppColor.primaryColor,
            ),
            child: const Icon(
              Icons.mood_bad_rounded,
              size: 60,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "ليس لديك موعد حاليًا",
            style: TextStyles.Bold16.copyWith(color: Colors.black),
          ),
          const Spacer(),
          CustomButton(
            title: "احجز موعدًا الآن",
            onPressed: () {
              GoRouter.of(context).push(AppRouter.KHomePage);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
