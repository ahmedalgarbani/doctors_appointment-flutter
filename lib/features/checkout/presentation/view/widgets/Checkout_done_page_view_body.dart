import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CheckoutDonePageViewBody extends StatelessWidget {
  const CheckoutDonePageViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            // Animated success circle
            Container(
              width: MediaQuery.sizeOf(context).width * 0.5,
              height: MediaQuery.sizeOf(context).width * 0.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColor.primaryColor.withOpacity(0.9),
                    AppColor.primaryColor.withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColor.primaryColor.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 5,
                  )
                ],
              ),
              child: const Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 90,
              ),
            ),
            const SizedBox(height: 32),
            // Success message
            Text(
              "تم حجز موعدك بنجاح!",
              style: TextStyles.Bold16.copyWith(
                color: AppColor.primaryColor,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              "سنقوم بمراجعة بيانات الحجز وسنتواصل معك قريباً",
              style: TextStyles.Bold12.copyWith(
                color: Colors.grey[600],
                fontSize: 16,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(flex: 3),
            // Action button
            CustomButton(
              title: "العودة للصفحة الرئيسية",
              onPressed: () {
                GoRouter.of(context).pushReplacement(AppRouter.KHomePage);
              },
              // width: double.infinity,
              // height: 56,
              // borderRadius: 12,
              // textStyle: TextStyles.Bold16.copyWith(
              //   color: Colors.white,
              //   fontSize: 18,
              // ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
