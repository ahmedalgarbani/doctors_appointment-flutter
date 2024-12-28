import 'package:doctors_appointment/core/constant/constant.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:flutter/material.dart';

import '../widgets/check_out_page_view_body.dart';

class CheckOutPageView extends StatelessWidget {
  const CheckOutPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Payment",
          style: TextStyles.Bold16.copyWith(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: KVerticalPadding, horizontal: KHorizantalPadding),
          child: CheckOutPageViewBody(),
        ),
      ),
    );
  }
}
