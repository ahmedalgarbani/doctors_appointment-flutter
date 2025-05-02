import 'package:doctors_appointment/features/home/data/models/speciality_response/doctor.dart';
import 'package:doctors_appointment/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:doctors_appointment/features/home/presentation/view_model/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/review_request.dart';
import 'add_review_section.dart';
import 'review_item.dart';

class ReviewsTab extends StatefulWidget {
  final Doctor? doctor;
  const ReviewsTab({super.key, this.doctor});

  @override
  State<ReviewsTab> createState() => _ReviewsTabState();
}

class _ReviewsTabState extends State<ReviewsTab> {
  final TextEditingController _reviewController = TextEditingController();
  double _currentRating = 0;

  void _submitReview() {
    if (_currentRating > 0 && _reviewController.text.isNotEmpty) {
      final reviewRequest = ReviewRequest(
        doctor: widget.doctor!.id!.toInt(),
        rating: _currentRating.toInt(),
        review: _reviewController.text.trim(),
      );

      context.read<HomeCubit>().submitDoctorReview(reviewRequest);
    }
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listenWhen: (previous, current) => current is ReviewSuccess || current is ReviewFailure,
      buildWhen: (previous, current) => current is ReviewLoading || current is ReviewSuccess,
      listener: (context, state) {
        if (state is ReviewSuccess) {
          
            widget.doctor?.reviews?.insert(0, state.review);
            _reviewController.clear();
            _currentRating = 0;
        
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(" تم إرسال المراجعة بنجاح")),
          );
        } else if (state is ReviewFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(" ${state.error}")),
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              AddReviewSection(
                controller: _reviewController,
                currentRating: _currentRating,
                onRatingChanged: (val) => setState(() => _currentRating = val),
                onSubmit: _submitReview,
              ),
              const SizedBox(height: 16),
              if (state is ReviewLoading) const CircularProgressIndicator(),
              ...widget.doctor!.reviews!
                  .map((review) => ReviewItem(review: review))
                  .toList(),
            ],
          ),
        );
      },
    );
  }
}
