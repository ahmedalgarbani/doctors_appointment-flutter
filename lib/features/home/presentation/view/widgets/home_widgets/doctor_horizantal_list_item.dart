import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/features/home/data/models/doctor_model.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/in_active_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/constant/constant.dart';
import '../../../../../../core/helpers/build_snacbar.dart';
import '../../../../../../core/helpers/shared_prefrace.dart';
import '../../../view_model/cubit/favorites_cubit/favorites_cubit.dart';

class DoctorHorizantalListCard extends StatelessWidget {
  const DoctorHorizantalListCard({
    super.key,
    required this.doctorModel,
    this.trailing,
    this.onPress,
  });

  final DoctorModel doctorModel;
  final Widget? trailing;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    final favoritesCubit = BlocProvider.of<FavoritesCubit>(context);

    return GestureDetector(
      onTap: onPress ??
          () {
            GoRouter.of(context).push(
              AppRouter.KDoctorDetail,
              extra: doctorModel,
            );
          },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Color.fromARGB(255, 225, 236, 251),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  doctorModel.imagePath!,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              // Doctor Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorModel.name,
                      style: TextStyles.Bold16.copyWith(color: Colors.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      doctorModel.specialtyName ?? '',
                      style: TextStyles.Bold12.copyWith(color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Price: \$${500}',
                      style: TextStyles.Bold16.copyWith(color: Colors.green),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          Icons.star,
                          color: index < 2 ? Colors.amber : Colors.grey[300],
                          size: 16,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              trailing ??
                  BlocBuilder<FavoritesCubit, FavoritesState>(
                    builder: (context, state) {
                      if (state is FavoritesLoaded) {
                        final isFavorite = state.favoritesDoctor!
                            .any((doctor) => doctor.id == doctorModel.id);
                        return IconButton(
                          icon: UnActiveItem(
                            icon: isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                          ),
                          onPressed: () =>
                              _toggleFavorite(context, favoritesCubit),
                        );
                      }
                      return const UnActiveItem(
                        icon: Icons.favorite_border,
                      );
                    },
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _toggleFavorite(
      BuildContext context, FavoritesCubit cubit) async {
    final isFavorite = await cubit.isFavorite(doctorId: doctorModel.id!);

    if (isFavorite) {
      _addFavorite(context, cubit);
    } else {
      _removeFavorite(context, cubit);
    }
  }

  Future<void> _addFavorite(BuildContext ctx, FavoritesCubit cubit) async {
    final patientId = await Pref.getInt(KauthUserId);

    if (patientId == 0) {
      buildSnackbar(
        ctx,
        "You need to login first!",
        color: Colors.redAccent,
      );
      return;
    }

    final result = await cubit.addNewFavorite(
      patientId: patientId,
      doctorId: doctorModel.id!,
    );

    if (result) {
      buildSnackbar(ctx, "Added to favorites!", color: Colors.greenAccent);
    } else {
      _removeFavorite(ctx, cubit);
    }

    cubit.getAllFavorites(patientId);
  }

  Future<void> _removeFavorite(BuildContext ctx, FavoritesCubit cubit) async {
    final patientId = await Pref.getInt(KauthUserId);

    if (patientId == 0) {
      buildSnackbar(
        ctx,
        "You need to login first!",
        color: Colors.redAccent,
      );
      return;
    }

    await cubit.removeFavorite(
      doctorId: doctorModel.id!,
      patientId: patientId,
    );

    cubit.getAllFavorites(patientId);
    buildSnackbar(ctx, "Removed from favorites!", color: Colors.orange);
  }
}
