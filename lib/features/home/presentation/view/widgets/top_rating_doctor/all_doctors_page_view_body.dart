import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/home_widgets/doctor_horizantal_list_item.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/speciality_response/doctor.dart';

class AllDoctorsPageViewBody extends StatelessWidget {
  const AllDoctorsPageViewBody({super.key, required this.doctors});
  final List<Doctor> doctors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: doctors.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: DoctorHorizantalListCard(
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: 60,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor.withOpacity(.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "4",
                          style:
                              TextStyles.Bold16.copyWith(color: Colors.black),
                        ),
                        Icon(
                          Icons.star,
                          color: AppColor.primaryColor,
                        ),
                      ],
                    ),
                  ),
                  doctorModel: doctors[index],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
