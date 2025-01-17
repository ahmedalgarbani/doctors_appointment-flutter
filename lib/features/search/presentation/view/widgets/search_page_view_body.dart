// ignore_for_file: must_be_immutable

import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/core/widgets/appbar.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/home_widgets/doctor_horizantal_list_item.dart';
import 'package:doctors_appointment/features/search/presentation/view_model/cubit/search_cubit.dart';
import 'package:doctors_appointment/features/search/presentation/view_model/cubit/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/empty_search.dart';
import '../../../../home/data/models/doctor_model.dart';
import 'search_field_page_view.dart';

class SearchPageViewBody extends StatelessWidget {
  SearchPageViewBody({super.key, required this.textString});
  final String textString;

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
          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              bool isEmpty = true;
              List<DoctorModel> recently = [];

              if (state is SearchedDataLoaded) {
                isEmpty = state.searchedData.isEmpty;
                recently = state.searchedData;
              } else if (state is SearchInitial || state is SearchEmpty) {
                isEmpty = true;
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchFieldPageView(
                    defaultValue: textString,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        context.read<SearchCubit>().search(value);
                      } else {
                        context.read<SearchCubit>().clearSearch();
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (isEmpty)
                    EmptySearch()
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Result Searching",
                          style: TextStyles.Bold16.copyWith(
                            color: AppColor.primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ...recently.map((doctor) => DoctorHorizantalListCard(
                              doctorModel: doctor,
                            )),
                      ],
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
