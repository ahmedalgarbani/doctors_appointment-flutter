import 'package:doctors_appointment/core/assets_helper/app_vectors.dart';
import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/appbar.dart';
import '../../../../core/widgets/base_button.dart';

class SignUpPageView extends StatelessWidget {
  SignUpPageView({super.key});

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: _navigationText(context),
        appBar: BaseAppBar(
          title: SvgPicture.asset(
            AppVectors.logo,
            height: 50,
            width: 50,
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _registerText(),
              SizedBox(
                height: 15,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'If you need any support',
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "click here",
                      style: TextStyle(color: AppColor.primaryColor),
                    ))
              ]),
              _inputField(context, hint: "Full Name", ParamController: _name),
              SizedBox(
                height: 20,
              ),
              _inputField(context,
                  hint: "Enter email", ParamController: _email),
              SizedBox(
                height: 20,
              ),
              _inputField(context,
                  hint: "Password", ParamController: _password),
              SizedBox(
                height: 20,
              ),
              BasicAppButton(
                onPressed: () async {
                  GoRouter.of(context).pushReplacement(AppRouter.KHomePage);
                },
                title: "creat an account",
                height: 60,
              ),
            ],
          ),
        ));
  }

  Widget _registerText() {
    return Text(
      "Sign Up",
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _inputField(BuildContext context,
      {String? hint, TextEditingController? ParamController}) {
    return TextField(
      controller: ParamController,
      decoration: InputDecoration(
        hintText: hint,
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  _navigationText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Do you have an account? ',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          TextButton(
            onPressed: () {
              GoRouter.of(context).pushReplacement(AppRouter.KSignin);
            },
            child: Text(
              'sign In',
              style: TextStyles.Bold16.copyWith(color: AppColor.primaryColor),
            ),
          )
        ],
      ),
    );
  }
}
