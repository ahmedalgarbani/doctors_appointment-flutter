import 'package:doctors_appointment/features/home/presentation/view/widgets/home_widgets/all_doctor_horizantal_list_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/style/app_color.dart';
import '../../../../../core/style/text_style.dart';
import '../../../data/models/speciality_response/doctor.dart';

class FavoriteDoctorViewBody extends StatelessWidget {
  const FavoriteDoctorViewBody({
    super.key,
    required this.allDoctors,
    this.isSetting = false,
  });

  final List<Doctor> allDoctors;
  final bool? isSetting;

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
    Color containerColor = Theme.of(context).brightness == Brightness.dark
        ? AppColor.darkBackground
        : AppColor.secondaryColor;
    Color iconColor = Theme.of(context).brightness == Brightness.dark
        ? AppColor.primaryColor
        : AppColor.primaryColor;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 22),
            child: Row(
              children: [
                if (isSetting == true)
                  IconButton(
                    onPressed: () => GoRouter.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                Text(
                  "الاطباء المفضلين",
                  style: TextStyles.Black20Bold.copyWith(color: textColor),
                ),
                const Spacer(),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: containerColor,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Center(
                    child: Icon(
                      Icons.sort,
                      color: iconColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ✅ استخدام الواجهة العمودية المفصلة
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: allDoctors.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final doctor = allDoctors[index];
              return DoctorListItem(
                doctor: doctor,
                onPressed: () {
                  // الانتقال إلى صفحة تفاصيل الطبيب
                  // يمكن تعديلها حسب التوجيه الموجود لديك
                },
                onBookingPressed: () {
                  // تنفيذ الحجز للطبيب
                  // يمكن تعديلها حسب التطبيق لديك
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
