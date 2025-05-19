import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:doctors_appointment/features/search/presentation/view_model/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
      if (category == 'Gender' || category == 'Stars') {
        if (activeFilters[category]!.contains(value)) {
          activeFilters[category]!.remove(value);
        } else {
          activeFilters[category]!.clear();
          activeFilters[category]!.add(value);
        }
      } else {
        if (activeFilters[category]!.contains(value)) {
          activeFilters[category]!.remove(value);
        } else {
          activeFilters[category]!.add(value);
        }
      }
    });
  }

  void clearFilters() {
    setState(() {
      activeFilters.forEach((key, value) => value.clear());
    });
  }

  void applyFilters() {
    final genderFilters = activeFilters['Gender'];
    final specialistFilters = activeFilters['Specialist'];
    final starsFilters = activeFilters['Stars'];

    final isAllEmpty = genderFilters!.isEmpty &&
        specialistFilters!.isEmpty &&
        starsFilters!.isEmpty;

    if (isAllEmpty) {
      context.read<SearchCubit>().clearSearch();
    } else {
      context.read<SearchCubit>().filter(
            genders: genderFilters,
            specialties: specialistFilters,
            stars: starsFilters!.isNotEmpty
                ? int.tryParse(starsFilters.first)
                : null,
          );
    }

    GoRouter.of(context).pop();
    GoRouter.of(context).pushReplacement(AppRouter.KallDoctors);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<String> specialties =
        context.read<HomeCubit>().allSpecialties.map((e) => e.name!).toList();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // المقبض العلوي
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: theme.dividerColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // العنوان
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'تصفية الأطباء',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, color: theme.colorScheme.onSurface),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),

          const SizedBox(height: 16),
          Divider(color: theme.dividerColor),

          _buildRatingFilter(theme),
          const SizedBox(height: 24),
          _buildGenderFilter(theme),
          const SizedBox(height: 24),
          _buildSpecialtiesFilter(theme, specialties),
          const SizedBox(height: 24),

          // أزرار الإجراءات
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: clearFilters,
                  child: Text(
                    'مسح',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: applyFilters,
                  child: Text(
                    'تطبيق التصفية',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingFilter(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'التقييم',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: List.generate(5, (index) {
            final starValue = (index + 1).toString();
            final isSelected = activeFilters['Stars']!.contains(starValue);
            return ChoiceChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(starValue),
                  const SizedBox(width: 4),
                  Icon(Icons.star, size: 18),
                ],
              ),
              selected: isSelected,
              onSelected: (_) => _toggleFilter('Stars', starValue),
              selectedColor: theme.colorScheme.primary.withOpacity(0.1),
              labelStyle: theme.textTheme.bodyMedium?.copyWith(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.dividerColor,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildGenderFilter(ThemeData theme) {
    final genderLabels = {
      'Male': 'ذكر',
      'Female': 'أنثى',
      'Other': 'أخرى',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الجنس',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: genderLabels.keys.map((genderKey) {
            final isSelected = activeFilters['Gender']!.contains(genderKey);
            return ChoiceChip(
              label: Text(genderLabels[genderKey]!),
              selected: isSelected,
              onSelected: (_) => _toggleFilter('Gender', genderKey),
              selectedColor: theme.colorScheme.primary.withOpacity(0.1),
              labelStyle: theme.textTheme.bodyMedium?.copyWith(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.dividerColor,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSpecialtiesFilter(ThemeData theme, List<String> specialties) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'التخصصات',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: specialties.map((specialty) {
            final isSelected = activeFilters['Specialist']!.contains(specialty);
            return FilterChip(
              label: Text(
                specialty,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface,
                ),
              ),
              selected: isSelected,
              onSelected: (_) => _toggleFilter('Specialist', specialty),
              selectedColor: theme.colorScheme.primary.withOpacity(0.1),
              backgroundColor: theme.colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.dividerColor,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            );
          }).toList(),
        ),
      ],
    );
  }
}
