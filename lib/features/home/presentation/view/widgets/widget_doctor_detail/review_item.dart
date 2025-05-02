import 'package:doctors_appointment/features/home/data/models/speciality_response/review.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/assets_helper/app_image.dart';

class ReviewItem extends StatelessWidget {
  final Review review;

  const ReviewItem({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: review.profilePicture != null
                ? NetworkImage(review.profilePicture ?? '')
                : AssetImage(AppImage.doctor01),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(review.userName ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  children: List.generate(5, (i) {
                    return Icon(
                      Icons.star,
                      color: i < review.rating!.round()
                          ? Colors.amber
                          : Colors.grey[300],
                      size: 16,
                    );
                  }),
                ),
                const SizedBox(height: 4),
                Text(review.review ?? '',
                    style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
