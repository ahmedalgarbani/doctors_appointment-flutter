import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/core/widgets/custom_button.dart';
import 'package:doctors_appointment/features/checkout/presentation/widgets/choisen_doctor.dart';
import 'package:doctors_appointment/features/checkout/presentation/widgets/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CheckOutPageViewBody extends StatelessWidget {
  const CheckOutPageViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              ChosenDoctor(),
              SizedBox(
                height: 25,
              ),
              PaymentMethod(),
              SizedBox(
                height: 15,
              ),
              Text(
                "please transfer money to this account\n781717609",
                style: TextStyles.Bold16.copyWith(color: Colors.redAccent),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                  label: Text(
                    "Enter a Transaction Number",
                    style: TextStyles.Bold12.copyWith(color: Colors.grey),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: buildOutLinedBorder(),
                  focusedBorder: buildOutLinedBorder(),
                  errorBorder: buildOutLinedBorder(),
                  disabledBorder: buildOutLinedBorder(),
                ),
              ),
            ],
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: CustomButton(
                onPressed: () {
                  GoRouter.of(context)
                      .pushReplacement(AppRouter.KCheckOutDonePageView);
                },
                title: "Complete",
              ),
            ),
          ),
        ),
      ],
    );
  }

  buildOutLinedBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
        borderSide: BorderSide(color: AppColor.primaryColor, width: 0.4));
  }
}
