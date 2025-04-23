import 'package:flutter/material.dart';

import '../../../../../core/style/text_style.dart';

class NotificationCardItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final IconData iconData;
  final bool isRead;

  const NotificationCardItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.iconData,
    this.isRead = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isRead ? Colors.grey.shade100 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.15),
            child: Icon(iconData, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subtitle, style: TextStyles.Regular16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
