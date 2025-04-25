import 'package:doctors_appointment/features/home/data/models/doctor_model.dart';
import 'package:doctors_appointment/features/home/data/models/speciality_response/doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/helpers/favorite_toggle.dart';
import '../../../view_model/cubit/favorites_cubit/favorites_cubit.dart';
import '../in_active_item.dart';

class FavoriteButtonCubit extends StatelessWidget {
  const FavoriteButtonCubit({
    super.key,
    required this.doctorModel,
    required this.favoritesCubit,
    this.isDetailButtton, required int iconSize,
  });

  final Doctor doctorModel;
  final FavoritesCubit favoritesCubit;
  final bool? isDetailButtton;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoaded) {
          final isFavorite = state.favoritesDoctor!
              .any((doctor) => doctor.id == doctorModel.id);
          return IconButton(
            icon: UnActiveItem(
              isDetailButtton: isDetailButtton,
              icon:
                  isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
            ),
            onPressed: () => FavoriteToggle.toggleFavorite(
                context, favoritesCubit, doctorModel),
          );
        }
        return const UnActiveItem(
          icon: Icons.favorite_border,
        );
      },
    );
  }
}
