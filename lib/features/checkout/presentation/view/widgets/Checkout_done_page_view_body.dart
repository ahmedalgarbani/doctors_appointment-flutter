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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Container(
          width: MediaQuery.sizeOf(context).width * .6,
          height: MediaQuery.sizeOf(context).height * .3,
          decoration: BoxDecoration(
              color: AppColor.primaryColor, shape: BoxShape.circle),
          child: Icon(
            Icons.done,
            color: Colors.white,
            size: 90,
          ),
        ),
        Text(
          "you order have booked successfuly!\nwe will check your payment and notic you later ",
          style: TextStyles.Bold12.copyWith(color: Colors.grey, fontSize: 14),
          textAlign: TextAlign.center,
        ),
        Spacer(),
        CustomButton(
          title: "Back To Home",
          onPressed: () {
            GoRouter.of(context).pushReplacement(AppRouter.KHomePage);
          },
        )
      ],
    );
  }
}
