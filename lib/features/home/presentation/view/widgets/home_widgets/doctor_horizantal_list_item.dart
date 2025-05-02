import 'package:doctors_appointment/core/router/router.dart';
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
      child: SizedBox(
        width: 175,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // البطاقة الرئيسية
            Container(
              margin: const EdgeInsets.only(top: 50),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFE0F7FA), Color(0xFFFFFFFF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    spreadRadius: 2,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Center(
                    child: trailing ??
                        FavoriteButtonCubit(
                          doctorModel: doctorModel,
                          favoritesCubit: favoritesCubit,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'د. ${doctorModel.fullName ?? 'غير معروف'}',
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    doctorModel.specialtyName ?? 'تخصص غير محدد',
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return Icon(
                        Icons.star_rounded,
                        color: (doctorModel.rating != null &&
                                index < doctorModel.rating!.toInt())
                            ? Colors.amber
                            : Colors.grey[300],
                        size: 18,
                      );
                    }),
                  ),
                ],
              ),
            ),

            // صورة الطبيب فوق البطاقة
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        doctorModel.photo ??
                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-978409_1280.png',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
