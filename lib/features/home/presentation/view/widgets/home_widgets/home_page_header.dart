import 'package:doctors_appointment/core/assets_helper/app_vectors.dart';
import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({
    super.key,
    this.title,
    this.iconData,
    this.onPressed,
  });
  final String? title;
  final IconData? iconData;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        // title: Text(
        //   title ?? "موعدي",
        //   style: TextStyles.Bold16.copyWith(color: Colors.black),
        // ),
        contentPadding: EdgeInsets.zero,
        leading: Container(
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            'assets/images/MyApp/loge.png',
            fit: BoxFit.contain,
            height: 40,
          ),
        ),

        trailing: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: AppColor.primaryColor.withOpacity(.3),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: IconButton(
              onPressed: onPressed ?? () {},
              icon: Icon(
                iconData ?? Icons.notifications,
                color: AppColor.primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
