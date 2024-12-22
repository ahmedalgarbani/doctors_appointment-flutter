
import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/navigation_item.dart';
import 'package:flutter/material.dart';

class CustomNavigationButton extends StatefulWidget {
  CustomNavigationButton({super.key});

  @override
  State<CustomNavigationButton> createState() => _CustomNavigationButtonState();
}

class _CustomNavigationButtonState extends State<CustomNavigationButton> {
  List<IconData> iconPaths = [
    Icons.home,
    Icons.menu,
    Icons.favorite,
    Icons.person
  ];

  final List<String> labels = ['home', 'history', 'favorite', 'profile'];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 70,
      width: double.infinity,
      decoration: ShapeDecoration(
        shadows: [
          BoxShadow(
            color: AppColor.primaryColor.withOpacity(0.2),
            blurRadius: 25,
            offset: Offset(0, -2),
            spreadRadius: 0,
          )
        ],
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: AppColor.primaryColor.withOpacity(0.2)
          ),
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
                  setState(
                    () {
                      selectedIndex = index;
                    },
                  );
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
