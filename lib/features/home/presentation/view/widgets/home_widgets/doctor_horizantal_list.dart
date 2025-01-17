// ignore_for_file: must_be_immutable

import 'package:doctors_appointment/core/helpers/build_snacbar.dart';
import 'package:doctors_appointment/core/helpers/shared_prefrace.dart';
import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/features/home/data/models/doctor_model.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/home_widgets/doctor_horizantal_list_item.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/in_active_item.dart';
import 'package:doctors_appointment/features/home/presentation/view_model/cubit/favorites_cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/constant/constant.dart';

class DoctorHorizantalList extends StatelessWidget {
  final List<DoctorModel> allDoctors;
  DoctorHorizantalList({Key? key, required this.allDoctors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<FavoritesCubit>(context);

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: allDoctors.length,
      itemBuilder: (context, index) {
        return BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, state) {
            bool isFavorite = false;
            if (state is FavoritesLoaded) {
              isFavorite = state.favoritesDoctor
                      ?.any((doctor) => doctor.id == allDoctors[index].id) ??
                  false;
            }

            return DoctorHorizantalListCard(
              trailing: IconButton(
                icon: UnActiveItem(
                    icon: isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border_outlined),
                onPressed: () => _toggleFavorite(cubit, context, index),
              ),
              onPress: () {
                GoRouter.of(context).push(AppRouter.KDoctorDetail,
                    extra: allDoctors[index] as DoctorModel);
              },
              doctorModel: allDoctors[index],
            );
          },
        );
      },
    );
  }

  Future<void> _toggleFavorite(
      FavoritesCubit cubit, BuildContext context, int index) async {
    final isFavorite = await cubit.isFavorite(doctorId: allDoctors[index].id!);

    if (isFavorite) {
      _addFavorite(cubit, context, index);
    } else {
      _removeFavorite(cubit, context, index);
    }
  }

  Future<void> _addFavorite(
      FavoritesCubit cubit, BuildContext ctx, int index) async {
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
      doctorId: allDoctors[index].id!,
    );

    if (result) {
      buildSnackbar(ctx, "Added to favorites!", color: Colors.greenAccent);
    } else {
      _removeFavorite(cubit, ctx, index);
    }

    cubit.getAllFavorites(patientId);
  }

  Future<void> _removeFavorite(
      FavoritesCubit cubit, BuildContext ctx, int index) async {
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
      doctorId: allDoctors[index].id!,
      patientId: patientId,
    );

    cubit.getAllFavorites(patientId);
    buildSnackbar(ctx, "Removed from favorites!", color: Colors.orange);
  }
}
