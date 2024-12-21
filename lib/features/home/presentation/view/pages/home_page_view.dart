import 'package:doctors_appointment/core/constant/constant.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/custom_navigation_button.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/home_page_view_body.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavigationButton(),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              top: KVerticalPadding,
              left: KHorizantalPadding,
              right: KHorizantalPadding),
          child: HomePageViewBody(),
        ),
      ),
    );
  }
}
