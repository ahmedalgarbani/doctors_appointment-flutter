import 'dart:developer';

import 'package:doctors_appointment/core/assets_helper/app_vectors.dart';
import 'package:doctors_appointment/core/helpers/shared_prefrace.dart';
import 'package:doctors_appointment/core/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constant/constant.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();

    Redirect();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FadeTransition(
          opacity: _fadeAnimation,
          child: SvgPicture.asset(
            AppVectors.FirstPageImg,
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }

  void Redirect() async {
    bool IsOnBoardingViewSeen = await Pref.getBool(kIsOnBoardingViewSeen);
    log("IsOnBoardingViewSeen $IsOnBoardingViewSeen");
    await Future.delayed(const Duration(milliseconds: 3000));
    await _controller.reverse();
    if (IsOnBoardingViewSeen) {
      GoRouter.of(context).pushReplacement(AppRouter.KHomePage);
    } else {
      GoRouter.of(context).go(AppRouter.KObBoarding);
    }
  }
}
