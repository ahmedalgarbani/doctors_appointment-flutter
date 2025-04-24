import 'package:doctors_appointment/core/helpers/build_snacbar.dart';
import 'package:flutter/material.dart';

import '../../features/home/data/models/speciality_response/doctor.dart';
import '../../features/home/presentation/view_model/cubit/favorites_cubit/favorites_cubit.dart';
import '../constant/constant.dart';
import 'shared_prefrace.dart';

abstract class FavoriteToggle {
  static Future<void> toggleFavorite(
      BuildContext context, FavoritesCubit cubit, Doctor doctorModel) async {
    final isFavorite =
        await cubit.isFavorite(doctorId: doctorModel.id!.toInt());

    if (isFavorite) {
      removeFavorite(context, cubit, doctorModel);
    } else {
      addFavorite(context, cubit, doctorModel);
    }
  }

  static Future<void> addFavorite(
      BuildContext ctx, FavoritesCubit cubit, Doctor doctorModel) async {
    final patientId = await Pref.getInt(KauthUserId);
    final userStatus = await Pref.getBool(KIsLogin);

    if (patientId == 0 || userStatus == false) {
      buildSnackbar(
        ctx,
        "You need to login first!",
        color: Colors.redAccent,
      );
      return;
    }

    final result = await cubit.addNewFavorite(
      doctorId: doctorModel.id!.toInt(),
    );

    if (result) {
      buildSnackbar(ctx, "Added to favorites!", color: Colors.greenAccent);
    } else {
      removeFavorite(ctx, cubit, doctorModel);
    }

    cubit.getAllFavorites();
  }

  static Future<void> removeFavorite(
      BuildContext ctx, FavoritesCubit cubit, Doctor doctorModel) async {
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
    );

    cubit.getAllFavorites();
    buildSnackbar(ctx, "Removed from favorites!", color: Colors.orange);
  }
}
