import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/in_active_item.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/top_rating_doctor/all_doctors_page_view_body.dart';
import 'package:doctors_appointment/features/search/presentation/view_model/cubit/search_cubit.dart';
import 'package:doctors_appointment/features/search/presentation/view_model/cubit/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/style/app_color.dart';
import '../../../../search/presentation/view/widgets/filter_bottom_sheet.dart';
import '../../../data/models/speciality_response/doctor.dart';

class AllDoctorsPageView extends StatefulWidget {
  const AllDoctorsPageView({super.key, this.allDoctors});
  final List<Doctor>? allDoctors;

  @override
  State<AllDoctorsPageView> createState() => _AllDoctorsPageViewState();
}

class _AllDoctorsPageViewState extends State<AllDoctorsPageView> {
  @override
  void initState() {
    super.initState();
    context.read<SearchCubit>().clearSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "All Doctors",
          style: TextStyles.Bold16.copyWith(color: Colors.black),
        ),
        actions: [
          UnActiveItem(
            icon: Icons.sort,
            onPressed: () {
              _showFilterBottomSheet(
                context,
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: BlocConsumer<SearchCubit, SearchState>(
              listener: (context, state) {
            // if (state is SearchFailure) {
            //   buildSnackbar(context, state.message);
            // }
          }, builder: (context, state) {
            if (state is SearchedDataFilter) {
              return AllDoctorsPageViewBody(
                doctors: state.searchedDataFiltered ?? [],
              );
            } else if (state is SearchEmpty) {
              return Text("no data came ");
            } else {
              return AllDoctorsPageViewBody(
                doctors:
                    widget.allDoctors?.length == 0 || widget.allDoctors == null
                        ? []
                        : widget.allDoctors!,
              );
            }
          }),
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: AppColor.whiteBackgrond,
      isScrollControlled: true,
      builder: (context) => const FilterBottomSheet(),
    );
  }
}
