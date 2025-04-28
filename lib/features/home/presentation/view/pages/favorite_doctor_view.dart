import 'package:doctors_appointment/core/helpers/build_snacbar.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/favorite_doctor_view_body.dart';
import 'package:doctors_appointment/features/home/presentation/view_model/cubit/favorites_cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteDoctorView extends StatelessWidget {
  const FavoriteDoctorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoaded) {
            return FavoriteDoctorViewBody(allDoctors: state.favoritesDoctor!);
          } else if (state is FavoritesLoading) {
            var allDoctors = context.watch<FavoritesCubit>().favorites;
            return FavoriteDoctorViewBody(allDoctors: allDoctors ?? []);
          }
          return const SizedBox();
        },
        listener: (BuildContext context, FavoritesState state) {
          if (state is FavoritesFailure) {
            buildSnackbar(context, state.message);
          }
        },
      ),
    );
  }
}
