
import 'package:doctors_appointment/core/assets_helper/app_vectors.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0x0A000000),
          blurRadius: 9,
          offset: Offset(0, 2),
          spreadRadius: 0,
        )
      ]),
      child: TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: "ابحث عن.......",
            hintStyle: TextStyles.Regular16.copyWith(
              color: const Color(0xFF949D9E),
            ),
            filled: true,
            fillColor: Color(0xFF949D9E).withOpacity(0.1),
            border: buildOutline(),
            enabledBorder: buildOutline(),
            focusedBorder: buildOutline(),
            prefixIcon: SizedBox(
              height: 20,
              width: 20,
              child: Center(child: SvgPicture.asset(AppVectors.search_normal)),
            ),
            // suffixIcon: SizedBox(
            //   height: 20,
            //   width: 20,
            //   child: Center(child: SvgPicture.asset(AppVector.filter_search)),
          )),
    );
  }

  OutlineInputBorder buildOutline() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(width: 1, color: Colors.white));
  }
}