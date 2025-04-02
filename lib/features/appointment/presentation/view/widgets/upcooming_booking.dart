import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/features/appointment/data/models/booking_model.dart';
import 'package:doctors_appointment/features/appointment/presentation/view/widgets/appointment_search_filed.dart';
import 'package:flutter/material.dart';

import 'booking_list_view_item.dart';

class UpcoomingBooking extends StatelessWidget {
  const UpcoomingBooking({super.key, required this.allBookings});
  final List<BookingModel> allBookings;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppointmentSearchField(),
            const SizedBox(height: 10),
            Text(
              "Wednesday, 2024-5-11 ",
              style: TextStyles.Bold16.copyWith(
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            BookingListViewItem(
              allBookings: allBookings,
            ),
           
          ],
        ),
      ),
    );
  }
}

