import 'dart:developer';

import 'package:doctors_appointment/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:doctors_appointment/features/search/presentation/view_model/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router/router.dart';
import '../../../../../core/style/text_style.dart';
import '../../../../../core/widgets/custom_button.dart';
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
    'Stars': [],
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

  void clearFiltersAndFetchAll() {
    setState(() {
      activeFilters.forEach((key, value) => value.clear());
    });

    // Fetch all doctors
    context.read<SearchCubit>().clearSearch();

    GoRouter.of(context).pop();
    GoRouter.of(context).pushReplacement(AppRouter.KallDoctors);
  }

  Widget buildStarsFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Top Stars',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(5, (index) {
              final starValue = (index + 1).toString();
              final isSelected = activeFilters['Stars']!.contains(starValue);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: FilterChip(
                  label: Text('$starValue ★'),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      activeFilters['Stars']!.clear();
                      activeFilters['Stars']!.add(starValue);
                    });
                  },
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget buildFilterSection(String category, List<String> filters) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(category,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
          itemCount: filters.length,
          itemBuilder: (context, index) {
            final filter = filters[index];
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
  }

  Widget buildApplyButton() {
    return CustomButton(
      height: 55,
      title: "Apply",
      onPressed: () {
        final genderFilters = activeFilters['Gender'];
        final specialistFilters = activeFilters['Specialist'];
        final starsFilters = activeFilters['Stars'];

        final isAllEmpty = genderFilters!.isEmpty &&
            specialistFilters!.isEmpty &&
            starsFilters!.isEmpty;

        if (isAllEmpty) {
          clearFiltersAndFetchAll();
          return;
        }

        context.read<SearchCubit>().filter(
              genders: genderFilters,
              specialties: specialistFilters,
              stars: starsFilters!.isNotEmpty
                  ? int.tryParse(starsFilters.first)
                  : null,
            );

        GoRouter.of(context).pop();
        GoRouter.of(context).pushReplacement(AppRouter.KallDoctors);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> specialties =
        context.read<HomeCubit>().allSpecialties.map((e) => e.name!).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildStarsFilter(),
            const SizedBox(height: 20),
            buildFilterSection('Gender', ['Male', 'Female', 'Other']),
            buildFilterSection('Specialist', specialties),
            buildApplyButton(),
            TextButton(
              onPressed: clearFiltersAndFetchAll,
              child: Text(
                "Clear the Filter",
                style: TextStyles.Bold12.copyWith(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
