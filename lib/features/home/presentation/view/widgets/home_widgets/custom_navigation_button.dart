import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/navigation_item.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomNavigationButton extends StatelessWidget {
  CustomNavigationButton(
      {super.key, required this.selectedIndex, required this.onChange});

  final int selectedIndex;
  final ValueChanged<int> onChange;

  List<IconData> iconPaths = [
    Icons.home,
    Icons.menu,
    Icons.favorite,
    Icons.person
  ];

  final List<String> labels = ['home', 'history', 'favorite', 'profile'];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 70,
      width: double.infinity,
      decoration: ShapeDecoration(
        shadows: [
          BoxShadow(
            color: AppColor.primaryColor.withOpacity(0.1),
            blurRadius: 1,
            offset: Offset(0, -2),
            spreadRadius: 0,
          )
        ],
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColor.primaryColor.withOpacity(0.2)),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
        ),
      ),
      child: Row(
        children: List.generate(
          iconPaths.length,
          (index) {
            return Expanded(
              flex: index == selectedIndex ? 2 : 1,
              child: GestureDetector(
                onTap: () {
                  onChange(index);
                },
                child: NaivgationBarItem(
                  icon: iconPaths[index],
                  isSelected: index == selectedIndex,
                  label: labels[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
