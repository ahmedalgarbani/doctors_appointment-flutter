
import 'package:flutter/material.dart';

import '../../../data/models/booking_model.dart';
import 'appointment_status.dart';
import 'booking_item.dart';

class BookingListViewItem extends StatelessWidget {
  const BookingListViewItem({super.key, required this.allBookings});
  final List<BookingModel> allBookings;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics:const NeverScrollableScrollPhysics(),
      itemCount: allBookings.length,
      itemBuilder: (context, index) {
        return BookingItem(
          bookingModel: allBookings[index],
          trailing: AppointmentStatusWidget(status: allBookings[index].status),
        );
      },
    );
  }
}


