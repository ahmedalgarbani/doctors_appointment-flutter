import 'package:doctors_appointment/features/home/presentation/view/widgets/top_rating_doctor/all_doctors_page_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/in_active_item.dart';
import 'package:doctors_appointment/features/search/presentation/view/widgets/filter_bottom_sheet.dart';
import 'package:doctors_appointment/features/home/data/models/speciality_response/doctor.dart';
import 'package:doctors_appointment/features/search/presentation/view_model/cubit/search_cubit.dart';
import 'package:doctors_appointment/features/search/presentation/view_model/cubit/search_state.dart';

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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "جميع الأطباء",
          style: TextStyles.Bold16.copyWith(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          UnActiveItem(
            icon: Icons.sort,
            onPressed: () => _showFilterBottomSheet(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: BlocConsumer<SearchCubit, SearchState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is SearchedDataFilter) {
                return AllDoctorsPageViewBody(
                  doctors: state.searchedDataFiltered ?? [],
                  onBookingPressed: (doctorId, hospitalId) {
                    // تنفيذ الحجز هنا
                  },
                );
              } else if (state is SearchEmpty) {
                return const Center(child: Text("لا توجد بيانات متاحة"));
              } else {
                return AllDoctorsPageViewBody(
                  doctors: widget.allDoctors ?? [],
                  onBookingPressed: (doctorId, hospitalId) {
                    // تنفيذ الحجز هنا
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: AppColor.whiteBackgrond,
      isScrollControlled: true,
      builder: (context) => const FilterBottomSheet(),
    );
  }
}
