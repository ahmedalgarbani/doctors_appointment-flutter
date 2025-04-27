import 'package:flutter/material.dart';
import 'add_review_section.dart';
import 'review_item.dart';

class ReviewsTab extends StatefulWidget {
  const ReviewsTab({super.key});

  @override
  State<ReviewsTab> createState() => _ReviewsTabState();
}

class _ReviewsTabState extends State<ReviewsTab> {
  final TextEditingController _reviewController = TextEditingController();
  double _currentRating = 0;

  final List<Map<String, dynamic>> _reviews = [
    {'name': 'أحمد', 'comment': 'طبيب رائع وخدمة ممتازة.', 'rating': 5.0},
    {'name': 'سارة', 'comment': 'تعامل جيد ولكن الانتظار طويل.', 'rating': 3.5},
  ];

  void _addReview() {
    if (_currentRating > 0 && _reviewController.text.isNotEmpty) {
      setState(() {
        _reviews.add({
          'name': 'مستخدم جديد',
          'comment': _reviewController.text,
          'rating': _currentRating,
        });
        _reviewController.clear();
        _currentRating = 0;
      });
    }
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          AddReviewSection(
            controller: _reviewController,
            currentRating: _currentRating,
            onRatingChanged: (val) => setState(() => _currentRating = val),
            onSubmit: _addReview,
          ),
          const SizedBox(height: 16),
          ..._reviews.map((review) => ReviewItem(review: review)).toList(),
        ],
      ),
    );
  }
}
