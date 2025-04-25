import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../data/models/speciality_response/doctor.dart';
import '../../../view_model/cubit/favorites_cubit/favorites_cubit.dart';
import 'favorite_button_cubit.dart';

class DoctorHorizantalListCard extends StatelessWidget {
  const DoctorHorizantalListCard({
    super.key,
    required this.doctorModel,
    this.trailing,
    this.onPress,
  });

  final Doctor doctorModel;
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
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      doctorModel.photo!=null?
                      doctorModel.photo!:'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-978409_1280.png',
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctorModel.fullName ?? 'د. غير معروف',
                          style: TextStyles.Bold16.copyWith(color: Colors.black),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          doctorModel.fullName ?? 'تخصص غير محدد',
                          style: TextStyles.Bold12.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  trailing ??
                      FavoriteButtonCubit(
                          doctorModel: doctorModel, 
                          favoritesCubit: favoritesCubit
                      ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text(
                  //   'ريال ${doctorModel.pricing ?? 'غير محدد'}',
                  //   style: TextStyles.Bold16.copyWith(
                  //     color: Colors.blue,
                  //     fontWeight: FontWeight.bold
                  //   ),
                  // ),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        Icons.star,
                        color: (doctorModel.rating != null && index < doctorModel.rating!.toInt())
                            ? Colors.amber
                            : Colors.grey[300],
                        size: 18,
                      );
                    }),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}