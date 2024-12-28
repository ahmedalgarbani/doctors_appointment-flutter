import 'package:doctors_appointment/core/assets_helper/app_vectors.dart';
import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:flutter/material.dart';

import '../../../../../core/style/text_style.dart';
import 'PageViewItem.dart';

class OnBoardingPageview extends StatelessWidget {
  const OnBoardingPageview({super.key, required this.pageController});
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PageView(
        controller: pageController,
        children: [
          PageViewItem(
              image: AppVectors.FirstPageImg,
              isVisible: true,
              subtitle:
                  "اكتشف تجربة حجز فريدة مع Doccure App. استكشف مجموعتنا الواسعة من الاطباء الماهرين والاشهر واحصل على أفضل العروض والجودة العالية.",
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "مرحبًا بك في   ",
                      style: TextStyles.Bold19,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Doccure",
                      style: TextStyles.Bold16.copyWith(
                          color: AppColor.primaryColor),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "App",
                      style: TextStyles.Bold16.copyWith(
                        color: AppColor.secondaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )),
          const PageViewItem(
            image: AppVectors.SecondPageImg,
            isVisible: false,
            subtitle:
                "باستخدام تطبيقنا يمكنك حجز المواعيد الطبيه بغطه زر وبكل سرعه وسهوله وتوفير للوقت والجهد",
            title: Text(
              "ابدا بالحجز",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
