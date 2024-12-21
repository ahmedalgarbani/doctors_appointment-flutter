
import 'package:doctors_appointment/core/assets_helper/app_vectors.dart';
import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        title: Text(
          "Docuure app",
          style: TextStyles.Black20Bold,
        ),
        contentPadding: EdgeInsets.zero,
        leading: ClipOval(
          child: SvgPicture.asset(AppVectors.logo),
        ),
        trailing: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: AppColor.primaryColor.withOpacity(.3),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Icon(
              Icons.notifications,
              color: AppColor.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
