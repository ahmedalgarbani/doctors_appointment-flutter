import 'package:doctors_appointment/features/home/data/models/speciality_response/pricing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/features/home/data/models/speciality_response/doctor.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/home_widgets/favorite_button_cubit.dart';
import 'package:doctors_appointment/features/home/presentation/view_model/cubit/favorites_cubit/favorites_cubit.dart';

class DoctorListItem extends StatelessWidget {
  final Doctor doctor;
  final VoidCallback onPressed;
  final VoidCallback onBookingPressed;

  const DoctorListItem({
    super.key,
    required this.doctor,
    required this.onPressed,
    required this.onBookingPressed,
  });

  @override
  Widget build(BuildContext context) {
    final favoritesCubit = BlocProvider.of<FavoritesCubit>(context);
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        color: Theme.of(context).cardColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        doctor.photo ?? '',
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                                Icon(Icons.person, size: 30, color: textColor),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'د. ${doctor.fullName ?? 'غير معروف'}',
                              style:
                                  TextStyles.Bold16.copyWith(color: textColor),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          FavoriteButtonCubit(
                            doctorModel: doctor,
                            favoritesCubit: favoritesCubit,
                          ),
                        ],
                      ),
                      Text(
                        doctor.specialtyName ?? 'التخصص غير معروف',
                        style: TextStyles.Regular14.copyWith(
                            color: textColor?.withOpacity(0.6)),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.work_outline,
                              size: 14,
                              color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 4),
                          Text(
                            '${doctor.experienceYears ?? 0} سنوات خبرة',
                            style:
                                TextStyles.Regular12.copyWith(color: textColor),
                          ),
                          const SizedBox(width: 12),
                          Icon(Icons.location_on_outlined,
                              size: 14,
                              color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              doctor.subTitle ?? 'غير محدد',
                              style: TextStyles.Regular12.copyWith(
                                  color: textColor),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.star,
                                    size: 16,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                const SizedBox(width: 4),
                                Text(
                                  doctor.rating?.toStringAsFixed(1) ?? '0.0',
                                  style: TextStyles.Bold16.copyWith(
                                      color: textColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // ✅ المستشفيات والأسعار
                      if (doctor.hospitals != null &&
                          doctor.hospitals!.isNotEmpty) ...[
                        // عرض أول مستشفيين فقط
                        ...doctor.hospitals!.take(2).map((hospital) {
                          final matchingPricing = doctor.pricing?.firstWhere(
                            (p) => p.hospital?.id == hospital.id,
                            orElse: () => Pricing(amount: null),
                          );

                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    hospital.name ?? 'مستشفى غير معروف',
                                    style: TextStyles.Regular14.copyWith(
                                        color: textColor),
                                  ),
                                ),
                                if (matchingPricing?.amount != null)
                                  Text(
                                    '${double.tryParse(matchingPricing!.amount!)?.toStringAsFixed(2) ?? '0.0'} ر.ي',
                                    style: TextStyles.Regular14.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                              ],
                            ),
                          );
                        }),

                        // زر عرض الكل إذا المستشفيات أكثر من 2
                        if (doctor.hospitals!.length > 2)
                          TextButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16)),
                                ),
                                builder: (context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children:
                                          doctor.hospitals!.map((hospital) {
                                        final matchingPricing =
                                            doctor.pricing?.firstWhere(
                                          (p) => p.hospital?.id == hospital.id,
                                          orElse: () => Pricing(amount: null),
                                        );

                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  hospital.name ??
                                                      'مستشفى غير معروف',
                                                  style: TextStyles.Regular14
                                                      .copyWith(
                                                          color: textColor),
                                                ),
                                              ),
                                              if (matchingPricing?.amount !=
                                                  null)
                                                Text(
                                                  '${double.tryParse(matchingPricing!.amount!)?.toStringAsFixed(2) ?? '0.0'} ر.ي',
                                                  style: TextStyles.Regular14
                                                      .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text(
                              'عرض الكل (${doctor.hospitals!.length})',
                              style: TextStyles.Regular14.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
