import 'package:doctors_appointment/core/constant/constant.dart';
import 'package:doctors_appointment/features/appointment/presentation/view/widgets/appointment_page_view_body.dart';
import 'package:flutter/material.dart';

class AppointmentPageView extends StatelessWidget {
  const AppointmentPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              left: KHorizantalPadding, right: KHorizantalPadding),
          child: AppointmentPageViewBody(),
        ),
      ),
    );
  }
}
