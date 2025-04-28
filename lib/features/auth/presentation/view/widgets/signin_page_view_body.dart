import 'package:doctors_appointment/core/assets_helper/app_vectors.dart';
import 'package:doctors_appointment/core/helpers/shared_prefrace.dart';
import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/core/widgets/custom_form_filed.dart';
import 'package:doctors_appointment/features/auth/data/model/signin_user_request.dart';
import 'package:doctors_appointment/features/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constant/constant.dart';
import '../../../../../core/widgets/appbar.dart';
import '../../../../../core/widgets/base_button.dart';

class SigninPageViewBody extends StatefulWidget {
  SigninPageViewBody({super.key});

  @override
  State<SigninPageViewBody> createState() => _SigninPageViewBodyState();
}

class _SigninPageViewBodyState extends State<SigninPageViewBody> {
  late String _email;
  late String _password;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness ==
        Brightness.dark; // التحقق من الوضع الداكن

    return Scaffold(
      backgroundColor:
          isDarkMode ? AppColor.darkBackground : AppColor.lightBackground,
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
        child: Form(
          key: _formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _signTitle(),
              _supportDescription(),
              SizedBox(
                height: 30,
              ),
              CustomFormFiled(
                hintText: "البريد الإلكتروني",
                textInputType: TextInputType.emailAddress,
                onSaved: (value) {
                  _email = value!;
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomFormFiled(
                hintText: "كلمة المرور",
                textInputType: TextInputType.text,
                obscureText: true,
                onSaved: (value) {
                  _password = value!;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Align(
                  child: Text(
                    "استعادة كلمة المرور",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  alignment: Alignment.topLeft,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              BasicAppButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    SigninUserRequest signinUserRequest = SigninUserRequest(
                      email: _email,
                      password: _password,
                    );
                    await BlocProvider.of<AuthCubit>(context)
                        .signinUserWithEmailAndPassword(
                            signinUserRequest: signinUserRequest);
                    await Pref.setBool(KIsLogin, true);
                  } else {
                    setState(() {
                      autovalidateMode = AutovalidateMode.always;
                    });
                  }
                },
                title: "تسجيل الدخول",
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // العنوان الخاص بتسجيل الدخول
  Text _signTitle() {
    return Text(
      "تسجيل الدخول",
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: AppColor.primaryColor,
      ),
      textAlign: TextAlign.center,
    );
  }

  // الزر الخاص بالتسجيل
  _buttonText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "ليس لديك حساب؟",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          TextButton(
            onPressed: () {
              GoRouter.of(context).pushReplacement(AppRouter.KSignup);
            },
            child: Text(
              "سجل الآن",
              style: TextStyles.Bold16.copyWith(color: AppColor.primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  // وصف الدعم
  _supportDescription() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        'إذا كنت بحاجة إلى الدعم',
        style: TextStyle(fontSize: 14),
      ),
      TextButton(
        onPressed: () {},
        child: Text(
          "اضغط هنا",
          style: TextStyle(color: AppColor.primaryColor),
        ),
      )
    ]);
  }
}
