// ignore_for_file: must_be_immutable

import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/core/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../core/widgets/empty_search.dart';
import 'search_field_page_view.dart';

class SearchPageViewBody extends StatelessWidget {
  SearchPageViewBody({super.key, required this.textString});
  final String textString;
  bool isEmpty = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseAppBar(
            title: Text(
              "Search",
              style: TextStyles.Black20Bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SearchFieldPageView(
            defaultValue: textString,
          ),
          SizedBox(
            height: 20,
          ),
          if (isEmpty) EmptySearch(),
          if (!isEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recent Search",
                  style: TextStyles.Bold16.copyWith(
                    color: AppColor.primaryColor,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            )
        ],
      ),
    );
  }
}
