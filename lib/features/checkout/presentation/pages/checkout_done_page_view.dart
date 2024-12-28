import 'package:doctors_appointment/core/constant/constant.dart';
import 'package:flutter/material.dart';

import '../widgets/Checkout_done_page_view_body.dart';

class CheckoutDonePageView extends StatelessWidget {
  const CheckoutDonePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: KHorizantalPadding, vertical: KVerticalPadding),
          child: CheckoutDonePageViewBody(),
        ),
      ),
    );
  }
}
