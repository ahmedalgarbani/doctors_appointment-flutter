import 'package:flutter/material.dart';

class ReviewItem extends StatelessWidget {
  final Map<String, dynamic> review;

  const ReviewItem({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/images/alkuraimi.png'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(review['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  children: List.generate(5, (i) {
                    return Icon(
                      Icons.star,
                      color: i < review['rating'].round() ? Colors.amber : Colors.grey[300],
                      size: 16,
                    );
                  }),
                ),
                const SizedBox(height: 4),
                Text(review['comment'], style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
