import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/features/home/data/models/speciality_response/doctor.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/home_widgets/doctor_horizantal_list_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DoctorHorizantalList extends StatelessWidget {
  final List<Doctor> allDoctors;
  DoctorHorizantalList({Key? key, required this.allDoctors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // لجعل الـ Listview أفقي
      child: Row(
        children: List.generate(allDoctors.length, (index) {
          // عرض زوج من الأطباء في السطر الواحد
          if (index % 2 == 0) {
            return Padding(
              padding:
                  const EdgeInsets.only(right: 16), // إضافة مسافة بين العناصر
              child: Row(
                children: [
                  DoctorHorizantalListCard(
                    onPress: () {
                      GoRouter.of(context).push(AppRouter.KDoctorDetail,
                          extra: allDoctors[index] as Doctor);
                    },
                    doctorModel: allDoctors[index],
                  ),
                  const SizedBox(width: 16), // إضافة المسافة بين البطاقات
                  if (index + 1 < allDoctors.length)
                    DoctorHorizantalListCard(
                      onPress: () {
                        GoRouter.of(context).push(AppRouter.KDoctorDetail,
                            extra: allDoctors[index + 1] as Doctor);
                      },
                      doctorModel: allDoctors[index + 1],
                    ),
                ],
              ),
            );
          }
          return Container(); 
        }),
      ),
    );
  }
}
