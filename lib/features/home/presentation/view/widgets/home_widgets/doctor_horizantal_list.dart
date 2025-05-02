import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/features/home/data/models/speciality_response/doctor.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/home_widgets/doctor_horizantal_list_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DoctorHorizantalList extends StatelessWidget {
  final List<Doctor> allDoctors;
  final bool isGrid;

  const DoctorHorizantalList({
    Key? key,
    required this.allDoctors,
    this.isGrid = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isGrid) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(8),
        itemCount: allDoctors.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.57,
        ),
        itemBuilder: (context, index) {
          return DoctorHorizantalListCard(
            onPress: () {
              GoRouter.of(context)
                  .push(AppRouter.KDoctorDetail, extra: allDoctors[index]);
            },
            doctorModel: allDoctors[index],
          );
        },
      );
    }

    // العرض الأفقي التقليدي
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(allDoctors.length, (index) {
          if (index % 2 == 0) {
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: [
                  DoctorHorizantalListCard(
                    onPress: () {
                      GoRouter.of(context).push(AppRouter.KDoctorDetail,
                          extra: allDoctors[index]);
                    },
                    doctorModel: allDoctors[index],
                  ),
                  const SizedBox(width: 16),
                  if (index + 1 < allDoctors.length)
                    DoctorHorizantalListCard(
                      onPress: () {
                        GoRouter.of(context).push(AppRouter.KDoctorDetail,
                            extra: allDoctors[index + 1]);
                      },
                      doctorModel: allDoctors[index + 1],
                    ),
                ],
              ),
            );
          }
          return Container(); // تخطي العناصر الفردية غير المتناسبة
        }),
      ),
    );
  }
}
