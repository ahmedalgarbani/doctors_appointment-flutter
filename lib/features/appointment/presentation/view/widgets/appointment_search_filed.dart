import 'package:doctors_appointment/core/assets_helper/app_vectors.dart';
import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/in_active_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppointmentSearchField extends StatelessWidget {
  const AppointmentSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        icon: const UnActiveItem(icon: Icons.sort),
        fillColor: AppColor.secondaryColor.withOpacity(0.7),
        filled: true,
        hintText: "ابحث عن مواعيدك السابقه...",
        hintStyle: TextStyles.Regular16.copyWith(
          color: const Color(0xFF949D9E),
        ),
        suffixIcon: SizedBox(
          height: 20,
          width: 20,
          child: Center(child: SvgPicture.asset(AppVectors.search_normal)),
        ),
        border: _buildOutline(),
        enabledBorder: _buildOutline(),
        focusedBorder: _buildOutline(),
      ),
    );
  }

  OutlineInputBorder _buildOutline() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(width: 1, color: AppColor.secondaryColor),
    );
  }
}
