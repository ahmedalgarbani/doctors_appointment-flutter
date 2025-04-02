import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChooseDateScnakBar extends StatelessWidget {
  const ChooseDateScnakBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      width: double.infinity,
      height: 250,
      child: Column(
        children: [
          Text(
            "October",
            style: TextStyles.Bold16.copyWith(color: Colors.black),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (index) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(84, 0, 0, 0),
                      blurRadius: 4.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                  color: AppColor.secondaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      "Mon",
                      style: TextStyles.Bold16.copyWith(color: Colors.black),
                    ),
                    Text(
                      "10",
                      style: TextStyles.Bold16.copyWith(color: Colors.black),
                    ),
                  ],
                ),
              );
            }),
          ),
          Spacer(),
          CustomButton(
            title: "Complete",
            onPressed: () {
              GoRouter.of(context).push(AppRouter.KCheckOutPageView);
            },
          )
        ],
      ),
    );
  }
}
