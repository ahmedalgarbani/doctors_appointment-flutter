
import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:flutter/material.dart';

class TopRatingStartsListItem extends StatelessWidget {
  const TopRatingStartsListItem({
    super.key,
    required this.activeIndex,
    required this.index,
    required this.reverseNumber,
  });

  final bool activeIndex;
  final int index;
  final int reverseNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      decoration: BoxDecoration(
        color: activeIndex ? AppColor.primaryColor : Colors.transparent,
        border: Border.all(
          width: 2,
          color: AppColor.primaryColor,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.star,
            color: activeIndex ? Colors.white : AppColor.primaryColor,
          ),
          Text(
            index == 0 ? "All" : " ${reverseNumber + 1}",
            style: TextStyles.Bold16.copyWith(
              color: activeIndex ? Colors.white : AppColor.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
