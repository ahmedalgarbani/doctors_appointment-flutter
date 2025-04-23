import 'package:doctors_appointment/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router/router.dart';
import '../../../../../core/style/text_style.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../home/presentation/view/widgets/top_rating_doctor/top_starts_list.dart';
import 'filter_card.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final Map<String, List<String>> activeFilters = {
    'Gender': [],
    'Specialist': [],
  };

  void _toggleFilter(String category, String value) {
    setState(() {
      if (activeFilters[category]!.contains(value)) {
        activeFilters[category]!.remove(value);
      } else {
        activeFilters[category]!.add(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, List<String>> filters = {
      'Gender': ['Male', 'Female', 'Other'],
      'Specialist':
          context.read<HomeCubit>().allSpecialties.map((e) => e.name!).toList(),
    };

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Top Stars',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: TopRatingStartsList(),
          ),
          const SizedBox(height: 20),
          ...filters.keys.map((category) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.5,
                  ),
                  itemCount: filters[category]!.length,
                  itemBuilder: (context, index) {
                    final filter = filters[category]![index];
                    return FilterCard(
                      title: filter,
                      isActive: activeFilters[category]!.contains(filter),
                      onTap: () => _toggleFilter(category, filter),
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            );
          }).toList(),
          CustomButton(
              height: 55,
              title: "Apply",
              onPressed: () {
                final genderFilters = activeFilters['Gender'];
                final specialistFilters = activeFilters['Specialist'];

                // context.read<HomeCubit>().filterDoctors(
                //       genders: genderFilters,
                //       specialties: specialistFilters,
                //     );

                GoRouter.of(context).pop();
                GoRouter.of(context).pushReplacement(AppRouter.KallDoctors);
              }),
          TextButton(
            onPressed: () {
              setState(() {
                activeFilters.forEach((key, value) => value.clear());
              });
            },
            child: Text(
              "Clear the Filter",
              style: TextStyles.Bold12.copyWith(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
