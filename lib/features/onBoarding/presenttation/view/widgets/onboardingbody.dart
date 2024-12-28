import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/widgets/custom_button.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constant/constant.dart';
import '../../../../../core/helpers/shared_prefrace.dart';
import 'onboardingpageview.dart';

class OnBoardingBody extends StatefulWidget {
  const OnBoardingBody({super.key});

  @override
  State<OnBoardingBody> createState() => _OnBoardingBodyState();
}

class _OnBoardingBodyState extends State<OnBoardingBody> {
  late PageController pageController;

  var currentPage = 0;
  @override
  void initState() {
    pageController = PageController();
    pageController.addListener(() {
      currentPage = pageController.page!.round();
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: OnBoardingPageview(pageController: pageController),
        ),
        DotsIndicator(
          dotsCount: 2,
          mainAxisAlignment: MainAxisAlignment.center,
          decorator: DotsDecorator(
            activeColor: AppColor.primaryColor,
            color: currentPage == 1
                ? AppColor.primaryColor
                : AppColor.secondaryColor,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Visibility(
          visible:
              (pageController.hasClients ? pageController.page!.round() : 0) !=
                  0,
          maintainAnimation: true,
          maintainState: true,
          maintainSize: true,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CustomButton(
                title: "ابدا الان",
                onPressed: () {
                  Pref.setBool(kIsOnBoardingViewSeen, true);
                  GoRouter.of(context).pushReplacement(AppRouter.KHomePage);
                },
              )),
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
