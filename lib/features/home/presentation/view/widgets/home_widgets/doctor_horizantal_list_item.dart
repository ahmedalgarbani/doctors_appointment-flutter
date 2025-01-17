import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/features/home/data/models/doctor_model.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/in_active_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DoctorHorizantalListCard extends StatelessWidget {
  const DoctorHorizantalListCard({
    super.key,
    required this.doctorModel,
    this.trailing,
    this.onPress,
  });

  final DoctorModel doctorModel;
  final Widget? trailing;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  doctorModel.imagePath!,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              // Doctor Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorModel.name,
                      style: TextStyles.Bold16.copyWith(color: Colors.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      doctorModel.specialtyName??'',
                      style: TextStyles.Bold12.copyWith(color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Price: \$${500}',
                      style: TextStyles.Bold16.copyWith(color: Colors.green),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          Icons.star,
                          color: index < 2
                              ? Colors.amber
                              : Colors.grey[300],
                          size: 16,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              trailing ??
                  UnActiveItem(
                    icon: Icons.favorite_border,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
