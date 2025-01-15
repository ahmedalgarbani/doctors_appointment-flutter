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
                hintText: "Email",
                textInputType: TextInputType.emailAddress,
                onSaved: (value) {
                  _email = value!;
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomFormFiled(
                hintText: "Password",
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
                title: "Sign In",
                height: 60,
              )
            ],
          ),
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
