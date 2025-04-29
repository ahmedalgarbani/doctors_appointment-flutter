import 'package:doctors_appointment/features/home/presentation/view/widgets/home_widgets/doctor_horizantal_list.dart';
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
    // تحديد اللون بناءً على وضع الجهاز
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
                isSetting == true
                    ? IconButton(
                        onPressed: () => GoRouter.of(context).pop(),
                        icon: Icon(Icons.arrow_back_ios))
                    : SizedBox(),
                Text(
                  "Favorites Doctors",
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
          DoctorHorizantalList(
            allDoctors: allDoctors,
            isGrid: true,
          ),
        ],
      ),
    );
  }
}
