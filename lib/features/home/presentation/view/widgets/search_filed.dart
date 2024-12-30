// ignore_for_file: must_be_immutable

import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/widgets/puffix_search_icon.dart';

class SearchField extends StatelessWidget {
  SearchField({super.key});
  TextEditingController _searchTextEdit = TextEditingController();
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
        controller: _searchTextEdit,
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
            prefixIcon: SuffixSearchIcon(
              onTap: () {
                GoRouter.of(context)
                    .push(AppRouter.KSearchPage, extra: _searchTextEdit.text);
              },
            )),
      ),
    );
  }

  OutlineInputBorder buildOutline() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(width: 1, color: Colors.white),
    );
  }
}
