import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/features/home/data/models/speciality_response/doctor.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/home_widgets/doctor_image.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/home_widgets/doctor_item_list.dart';
import 'package:flutter/material.dart';

class DoctorHeader extends StatelessWidget {
  final Doctor doctor;

  const DoctorHeader({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              DoctorImage(
                doctorImage: doctor.photo ?? '',
                doctorId: doctor.id!.toInt(),
                size: 5,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('د. ${doctor.fullName ?? 'غير معروف'}',
                        style: TextStyles.Regular16.copyWith(
                            fontWeight: FontWeight.bold)),
                    Text(doctor.subTitle ?? 'التخصص غير معروف',
                        style:
                            TextStyles.Regular16.copyWith(color: Colors.grey)),
                    const SizedBox(height: 8),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          Icons.star_rounded,
                          color: (doctor.rating != null &&
                                  index < doctor.rating!.toInt())
                              ? Colors.amber
                              : Colors.grey[300],
                          size: 18,
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          DoctorItemList(doctorModel: doctor),
        ],
      ),
    );
  }
}
