import 'package:doctors_appointment/features/home/presentation/view/widgets/active_item.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/in_active_item.dart';
import 'package:flutter/material.dart';

class NaivgationBarItem extends StatelessWidget {
  const NaivgationBarItem(
      {super.key,
      required this.icon,
      required this.isSelected,
      required this.label});
  final IconData icon;
  final bool isSelected;
  final String label;

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? ActiveItem(
            icon: icon,
            label: label,
          )
        : UnActiveItem(
            icon: icon,
          );
  }
}
