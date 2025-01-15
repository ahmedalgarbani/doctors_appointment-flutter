import 'dart:io';

import 'package:doctors_appointment/core/assets_helper/app_vectors.dart';
import 'package:doctors_appointment/core/helpers/save_image_to_system_file.dart';
import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/core/widgets/custom_button.dart';
import 'package:doctors_appointment/features/auth/data/model/create_user_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/appbar.dart';
import '../../../../core/widgets/custom_form_filed.dart';
import '../../../../core/widgets/custom_gender_form_field.dart';
import '../../../../core/widgets/date_picker_input_field.dart';
import '../../../../core/widgets/image_picker_input.dart';
import '../view_model/cubit/auth_cubit.dart';

class SignUpPageViewBody extends StatefulWidget {
  SignUpPageViewBody({super.key});

  @override
  State<SignUpPageViewBody> createState() => _SignUpPageViewBodyState();
}

class _SignUpPageViewBodyState extends State<SignUpPageViewBody> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _fullName,
      _email,
      _password,
      _note,
      _address,
      _birthdate,
      _gender,
      _phoneNumber;

  late File _pickImage;

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
        child: Form(
          key: _formKey,
          autovalidateMode: autovalidateMode,
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
              CustomFormFiled(
                hintText: "Full Name",
                textInputType: TextInputType.text,
                onSaved: (name) {
                  _fullName = name!;
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomFormFiled(
                hintText: "Email Address",
                textInputType: TextInputType.emailAddress,
                onSaved: (value) {
                  _email = value!;
                },
              ),
              SizedBox(
                height: 20,
              ),
              DatePickerInputField(
                hintText: "birthDate",
                onDateSelected: (date) {
                  _birthdate = date.toString();
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomGenderFormField(
                hintText: "Gender",
                onChanged: (gender) {
                  _gender = gender.toString();
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomFormFiled(
                hintText: "address",
                textInputType: TextInputType.text,
                onSaved: (value) {
                  _address = value!;
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomFormFiled(
                hintText: "Phone Number",
                textInputType: TextInputType.number,
                onSaved: (value) {
                  _phoneNumber = value!;
                },
              ),
              SizedBox(
                height: 20,
              ),
              ImagePickerInputField(
                onImageSelected: (image) {
                  _pickImage = image!;
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomFormFiled(
                hintText: "Note",
                line: 2,
                textInputType: TextInputType.text,
                onSaved: (value) {
                  _note = value!;
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomFormFiled(
                hintText: "Password",
                obscureText: true,
                textInputType: TextInputType.text,
                onSaved: (value) {
                  _password = value!;
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                title: "creat an account",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final imagePath =
                        await saveImageToSystemFile(imageFile: _pickImage);
                    Patient patient = Patient(
                        fullName: _fullName,
                        birthDate: _birthdate,
                        gender: _gender,
                        address: _address,
                        phoneNumber: _phoneNumber,
                        email: _email,
                        profilePicture: imagePath,
                        notes: _note,
                        joinDate: DateTime.now().toString(),
                        password: _password);
                    BlocProvider.of<AuthCubit>(context)
                        .createUserWithEmailAndPassword(patient: patient);
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
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

  _navigationText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
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
