// ignore_for_file: must_be_immutable

import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:flutter/material.dart';

class CustomGenderFormField extends StatefulWidget {
  CustomGenderFormField({
    super.key,
    required this.onChanged,
    required this.hintText,
    this.selectedValue,
  });

  final String hintText;
  final Function(String?) onChanged;
  final String? selectedValue;

  @override
  State<CustomGenderFormField> createState() => _CustomGenderFormFieldState();
}

class _CustomGenderFormFieldState extends State<CustomGenderFormField> {
  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RadioListTile<String>(
            tileColor: AppColor.secondaryColor.withOpacity(.5),
            value: "male",
            groupValue: _selectedGender,
            title: Text(
              "Male",
              style: TextStyles.Bold16.copyWith(color: Colors.black),
            ),
            onChanged: (value) {
              setState(() {
                _selectedGender = value;
              });
              widget.onChanged(value);
            },
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: RadioListTile<String>(
            tileColor: AppColor.secondaryColor.withOpacity(.5),
            value: "female",
            groupValue: _selectedGender,
            title: Text(
              "Female",
              style:
                  TextStyles.Bold16.copyWith(color: Colors.black, fontSize: 14),
            ),
            onChanged: (value) {
              setState(() {
                _selectedGender = value;
              });
              widget.onChanged(value);
            },
          ),
        ),
      ],
    );
  }
}
