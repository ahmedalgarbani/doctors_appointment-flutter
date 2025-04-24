import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/core/widgets/appbar.dart';
import 'package:doctors_appointment/core/widgets/empty_search.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/home_widgets/doctor_horizantal_list_item.dart';
import 'package:doctors_appointment/features/search/presentation/view_model/cubit/search_cubit.dart';
import 'package:doctors_appointment/features/search/presentation/view_model/cubit/search_state.dart';

import '../../../../home/data/models/speciality_response/doctor.dart';
import 'search_field_page_view.dart';

class SearchPageViewBody extends StatefulWidget {
  final String textString;
  const SearchPageViewBody({super.key, required this.textString});

  @override
  State<SearchPageViewBody> createState() => _SearchPageViewBodyState();
}

class _SearchPageViewBodyState extends State<SearchPageViewBody> {
  Timer? _debounce;

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 600), () {
      final query = value.trim();
      if (query.isNotEmpty) {
        context.read<SearchCubit>().search(query);
      } else {
        context.read<SearchCubit>().clearSearch();
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

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
          const SizedBox(height: 20),
          SearchFieldPageView(
            defaultValue: widget.textString,
            onChanged: _onSearchChanged,
          ),
          const SizedBox(height: 20),
          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              log(state.toString());
              if (state is SearchedDataLoaded) {
                if (state.searchedData.isEmpty) {
                  return const EmptySearch();
                }
                return _buildDoctorList(state.searchedData);
              } else if (state is SearchEmpty || state is SearchInitial) {
                return const EmptySearch();
              } else {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorList(List<Doctor> doctors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Result Searching",
          style: TextStyles.Bold16.copyWith(
            color: AppColor.primaryColor,
          ),
        ),
        const SizedBox(height: 10),
        ...doctors.map((doctor) => DoctorHorizantalListCard(
              doctorModel: doctor,
            )),
      ],
    );
  }
}
