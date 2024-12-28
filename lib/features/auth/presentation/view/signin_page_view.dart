import 'package:doctors_appointment/core/assets_helper/app_vectors.dart';
import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/appbar.dart';
import '../../../../core/widgets/base_button.dart';

class SigninPageView extends StatelessWidget {
  SigninPageView({super.key});
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buttonText(context),
      appBar: BaseAppBar(
        hideBack: false,
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
            _signTitle(),
            _supportDescription(),
            SizedBox(
              height: 30,
            ),
            _inputField(context, hint: "email", sendedController: _email),
            SizedBox(
              height: 20,
            ),
            _inputField(context, hint: "password", sendedController: _password),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Align(
                child: Text(
                  "Recovery password",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                alignment: Alignment.topLeft,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            BasicAppButton(
              onPressed: () {
                GoRouter.of(context).pushReplacement(AppRouter.KHomePage);
              },
              title: "Sign In",
              height: 60,
            )
          ],
        ),
      ),
    );
  }

  Text _signTitle() {
    return Text(
      "Sign In",
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _inputField(BuildContext context,
      {String? hint, TextEditingController? sendedController}) {
    return TextField(
      controller: sendedController,
      decoration: InputDecoration(
        hintText: hint,
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  _buttonText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "not a member ?",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          TextButton(
            onPressed: () {
              GoRouter.of(context).pushReplacement(AppRouter.KSignup);
            },
            child: Text(
              "register now",
              style: TextStyles.Bold16.copyWith(color: AppColor.primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  _supportDescription() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        'If you need any support',
      ),
      TextButton(
          onPressed: () {},
          child: Text(
            "click here",
            style: TextStyle(color: AppColor.primaryColor),
          ))
    ]);
  }
}
