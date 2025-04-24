import 'package:doctors_appointment/core/assets_helper/app_vectors.dart';
import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/base_button.dart';

class SigninOrLogin extends StatelessWidget {
  const SigninOrLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppVectors.logo),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "قم بالتسجل للحصول على جميع الميزات",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "تطبيق Doccure App  يوفر تجربه حجز مواعيد طبيه امنه وسريعه وفريده",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff797979),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: BasicAppButton(
                          onPressed: () {
                            GoRouter.of(context).push(AppRouter.KSignup);
                          },
                          title: "SignUp",
                          height: 70,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextButton(
                          child: Text(
                            "Sign in",
                            style: TextStyles.Bold19.copyWith(
                                color: AppColor.primaryColor),
                          ),
                          onPressed: () {
                            GoRouter.of(context).push(AppRouter.KSignin);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
