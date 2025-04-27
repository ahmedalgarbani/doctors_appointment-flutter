import 'package:doctors_appointment/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class AddReviewSection extends StatelessWidget {
  final TextEditingController controller;
  final double currentRating;
  final Function(double) onRatingChanged;
  final VoidCallback onSubmit;

  const AddReviewSection({
    super.key,
    required this.controller,
    required this.currentRating,
    required this.onRatingChanged,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('أضف تقييمك:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                index < currentRating ? Icons.star : Icons.star_border,
                color: Colors.amber,
              ),
              onPressed: () => onRatingChanged(index + 1.0),
            );
          }),
        ),
        TextField(
          controller: controller,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'اكتب تعليقك هنا...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(height: 8),
        CustomButton(
          onPressed: onSubmit,
          title: 'إرسال',
        ),
      ],
    );
  }
}
