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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/appbar.dart';
import '../../../../core/widgets/custom_form_filed.dart';
import '../../../../core/widgets/custom_gender_form_field.dart';
import '../../../../core/widgets/date_picker_input_field.dart';
import '../../../../core/widgets/image_picker_input.dart';
import '../view_model/cubit/auth_cubit.dart';

class SignUpPageViewBody extends StatefulWidget {
  const SignUpPageViewBody({super.key});

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
    final bool isDarkMode =
        Theme.of(context).brightness == Brightness.dark; // التحقق من الوضع

    return Scaffold(
      backgroundColor:
          isDarkMode ? AppColor.darkBackground : AppColor.lightBackground,
      bottomNavigationBar: _navigationText(context),
      appBar: BaseAppBar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 50,
          width: 50,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Form(
          key: _formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _registerText(),
              const SizedBox(height: 20),
              _supportText(),
              const SizedBox(height: 30),
              _buildTextInputField(
                hintText: 'الاسم الكامل',
                onSaved: (name) => _fullName = name!,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 20),
              _buildTextInputField(
                hintText: 'البريد الإلكتروني',
                onSaved: (email) => _email = email!,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              _buildDatePicker(),
              const SizedBox(height: 20),
              _buildGenderPicker(),
              const SizedBox(height: 20),
              _buildTextInputField(
                hintText: 'العنوان',
                onSaved: (address) => _address = address!,
                keyboardType: TextInputType.streetAddress,
              ),
              const SizedBox(height: 20),
              _buildTextInputField(
                hintText: 'رقم الهاتف',
                onSaved: (phone) => _phoneNumber = phone!,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              _buildImagePicker(),
              const SizedBox(height: 20),
              _buildTextInputField(
                hintText: 'ملاحظات (اختياري)',
                onSaved: (note) => _note = note!,
                keyboardType: TextInputType.text,
                maxLines: 2,
              ),
              const SizedBox(height: 20),
              _buildTextInputField(
                hintText: 'كلمة المرور',
                onSaved: (password) => _password = password!,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),
              const SizedBox(height: 30),
              _buildSignUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for "Create Account" Text
  Widget _registerText() {
    return Text(
      "إنشاء حساب",
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColor.primaryColor,
      ),
      textAlign: TextAlign.center,
    );
  }

  // Widget for support text
  Widget _supportText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'هل تحتاج إلى دعم؟ ',
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            "انقر هنا",
            style: TextStyle(color: AppColor.primaryColor),
          ),
        ),
      ],
    );
  }

  // Generic Text Input field
  Widget _buildTextInputField({
    required String hintText,
    required FormFieldSetter<String> onSaved,
    required TextInputType keyboardType,
    bool obscureText = false,
    int maxLines = 1,
  }) {
    return CustomFormFiled(
      hintText: hintText,
      onSaved: onSaved,
      textInputType: keyboardType,
      obscureText: obscureText,
      line: maxLines,
    );
  }

  // Date Picker Input field
  Widget _buildDatePicker() {
    return DatePickerInputField(
      hintText: "تاريخ الميلاد",
      onDateSelected: (date) => _birthdate = date.toString(),
    );
  }

  // Gender Picker Input field
  Widget _buildGenderPicker() {
    return CustomGenderFormField(
      hintText: "الجنس",
      onChanged: (gender) => _gender = gender.toString(),
    );
  }

  // Image Picker Input field
  Widget _buildImagePicker() {
    return ImagePickerInputField(
      onImageSelected: (image) => _pickImage = image!,
    );
  }

  // Sign Up button
  Widget _buildSignUpButton() {
    return CustomButton(
      title: "إنشاء الحساب",
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          final imagePath = await saveImageToSystemFile(imageFile: _pickImage);
          Patient patient = Patient(
            first_name: _fullName,
            last_name: "",
            birthDate: _birthdate,
            gender: _gender,
            address: _address,
            phoneNumber: _phoneNumber,
            email: _email,
            profilePicture: imagePath,
            notes: _note,
            joinDate: DateTime.now().toString(),
            password: _password,
          );
          BlocProvider.of<AuthCubit>(context)
              .createUserWithEmailAndPassword(patient: patient);
        } else {
          setState(() {
            autovalidateMode = AutovalidateMode.always;
          });
        }
      },
    );
  }

  // Navigation Text for "Do you have an account?"
  _navigationText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'هل لديك حساب؟ ',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          TextButton(
            onPressed: () {
              GoRouter.of(context).pushReplacement(AppRouter.KSignin);
            },
            child: Text(
              'تسجيل الدخول',
              style: TextStyles.Bold16.copyWith(color: AppColor.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
