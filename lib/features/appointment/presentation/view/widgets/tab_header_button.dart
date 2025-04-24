import 'package:doctors_appointment/features/appointment/presentation/view/widgets/tab_header_item.dart';
import 'package:flutter/material.dart';

class TabHeaderButton extends StatelessWidget {
  final int activeTab;
  final ValueChanged<int> onTabChange;

  const TabHeaderButton({
    super.key,
    required this.activeTab,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TabHeaderItem(
          title: "Upcoming",
          isActive: activeTab == 0,
          onTap: () => onTabChange(0),
        ),
        TabHeaderItem(
          title: "Past",
          isActive: activeTab == 1,
          onTap: () => onTabChange(1),
        ),
      ],
    );
  }
}
