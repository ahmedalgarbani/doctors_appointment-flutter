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
  DoctorHorizantalList({super.key, required this.allDoctors});
  List<DoctorModel> allDoctors;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: allDoctors.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            GoRouter.of(context).push(AppRouter.KDoctorDetail);
          },
          child: DoctorHorizantalListCard(
            trailing: UnActiveItem(
                icon: Icons.favorite_border_outlined,
                onPressed: () => buildADdItemToFavorite(context, index)),
            onPress: () {
              GoRouter.of(context).push(AppRouter.KDoctorDetail);
            },
            doctorModel: allDoctors[index],
          ),
        );
      },
    );
  }

  buildADdItemToFavorite(context, index) async {
    final cubit = BlocProvider.of<FavoritesCubit>(context);
    final patientId = await Pref.getInt(KauthUserId);
    if (patientId == 0) {
      buildSnackbar(
        context,
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
      buildSnackbar(context, 'doctor added succesfuly', color: Colors.green);
    }else{
      buildSnackbar(context, 'doctor is already aded');

    }

    cubit.getAllFavorites(patientId);
  }
}
