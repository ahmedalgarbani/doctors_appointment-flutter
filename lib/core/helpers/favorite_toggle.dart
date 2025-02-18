import 'package:doctors_appointment/core/helpers/build_snacbar.dart';
import 'package:doctors_appointment/features/home/data/models/doctor_model.dart';
import 'package:flutter/material.dart';

import '../../features/home/presentation/view_model/cubit/favorites_cubit/favorites_cubit.dart';
import '../constant/constant.dart';
import 'shared_prefrace.dart';

abstract class FavoriteToggle {

  static Future<void> toggleFavorite(BuildContext context,
      FavoritesCubit cubit, DoctorModel doctorModel) async {
    final isFavorite = await cubit.isFavorite(doctorId: doctorModel.id!);

    if (isFavorite) {
      addFavorite(context, cubit, doctorModel);
    } else {
      removeFavorite(context, cubit, doctorModel);
    }
  }

 static Future<void> addFavorite(BuildContext ctx, FavoritesCubit cubit,DoctorModel doctorModel) async {
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
      removeFavorite(ctx, cubit,doctorModel);
    }

    cubit.getAllFavorites(patientId);
  }

 static Future<void> removeFavorite(BuildContext ctx, FavoritesCubit cubit,DoctorModel doctorModel) async {
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
