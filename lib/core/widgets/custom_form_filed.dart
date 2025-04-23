// ignore_for_file: must_be_immutable

import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:flutter/material.dart';

class CustomFormFiled extends StatelessWidget {
  CustomFormFiled(
      {super.key,
      required this.hintText,
      this.obscureText = false,
      this.suffixIcon,
      required this.textInputType,
      this.line,
      this.onSaved});
  final bool obscureText;
  final TextInputType textInputType;
  final String hintText;
  final Widget? suffixIcon;
  final int? line;
  void Function(String?)? onSaved;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: line ?? 1,
      onSaved: onSaved,
      obscureText: obscureText,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'required input ';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: hintText,
        border: buildBorder(),
        hintStyle: TextStyles.Bold12.copyWith(
          color: const Color(0xFF949D9E),
        ),
        filled: true,
        fillColor: AppColor.secondaryColor.withOpacity(.5),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
        suffix: suffixIcon,
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(
        width: 1,
        color: Color(0xFFE6E9E9),
      ),
    );
  }
}
